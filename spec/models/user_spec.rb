require 'spec_helper'

describe User do
  
  before(:each) do
    @attr = {
      :email => "user@example.com",
      :password => "foobar",
      :password_confirmation => "foobar"
    }
  end

  it 'should create a new instance given valid attributes' do
    User.create!(@attr)
  end
    
  context "is not valid" do

    [:email, :password].each  do |attr|
      it "without #{attr}" do
        subject.should_not be_valid
        subject.errors[attr].should_not be_empty
      end
    end
  end
  
  it 'should accept valid email addresses' do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end
  
  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end  
  
  it "should reject duplicate email addresses" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  describe "passwords" do

    before(:each) do
      @user = User.new(@attr)
    end

    it "should have a password attribute" do
      @user.should respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      @user.should respond_to(:password_confirmation)
    end
  end  
  
  describe "password validations" do

    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end
    
    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end
    
    it "should reject long passwords" do
      long = "a" * 21
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end
  end
  
  describe 'ingredient associations' do
   
    before(:each) do
      @user = User.create(@attr)
      @ing1 = Factory(:ingredient, :user => @user, :created_at => 1.day.ago)
      @ing2 = Factory(:ingredient, :user => @user, :created_at => 1.hour.ago)
    end
    
    it 'should have an ingredients attribute' do
      @user.should respond_to(:ingredients)
    end
    
    it 'should destroy associated ingredients' do
      @user.destroy
      [@ing1, @ing2].each do |ingredient|
        lambda do
          Ingredient.find(ingredient)
        end.should raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
