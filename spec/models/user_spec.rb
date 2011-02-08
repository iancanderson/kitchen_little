require 'spec_helper'

describe User do

  context "is not valid" do
    
    [:email, :password].each do |attr|
      it "without #{attr}" do
        subject.should_not be_valid
        subject.errors[attr].should_not be_empty
      end
    end

    it "with an invalid email address" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
      addresses.each do |address|
        subject.email = address
        subject.should_not be_valid
        subject.errors[:email].should_not be_empty
      end
    end

    it "with a duplicate email address, same case" do
      existing_user = Factory.create(:user)
      lambda{
       new_user = Factory.create(:user, :email => existing_user.email) 
      }.should raise_error(ActiveRecord::RecordInvalid, /already been taken/)
    end

    it "with a duplicate email address, different case" do
      existing_user = Factory.create(:user)
      lambda{
        new_user = Factory.create(:user, :email => existing_user.email.swapcase)
      }.should raise_error(ActiveRecord::RecordInvalid, /already been taken/)
    end

    it "with an inconsistent password confirmation" do
      user = Factory.build(:user, :password_confirmation => "wrong")
      user.should_not be_valid
      user.errors[:password].should_not be_empty 
    end

    it "with a short password" do
      subject.password = "a"*5
      subject.should_not be_valid
      subject.errors[:password].should_not be_empty
    end

    it "with a long password" do
      subject.password = "a"*21
      subject.should_not be_valid
      subject.errors[:password].should_not be_empty
    end
  end

  context "is valid" do

    it "with a valid email address" do
      addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
      addresses.each do |address|
        subject = Factory.build(:user, :email => address)
        subject.should be_valid
      end
    end
  end

  it "has ingredients" do
    should respond_to(:ingredients)
  end

  it "should destroy associated ingredients" do
    ingredient = Factory.create(:ingredient)
    ingredient.user.destroy
    lambda do
      Ingredient.find(ingredient)
    end.should raise_error(ActiveRecord::RecordNotFound)
  end

  it "has recipes" do
    should respond_to(:recipes)
  end

  it "should destroy associated recipes" do
    recipe = Factory.create(:recipe)
    recipe.user.destroy
    lambda do
      Recipe.find(recipe)
    end.should raise_error(ActiveRecord::RecordNotFound)
  end
end
