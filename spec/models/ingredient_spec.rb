require 'spec_helper'

describe Ingredient do

  before(:each) do
    @user = Factory(:user)
    @attr = { :name => "garlic" }
  end
  
  it 'should create a new instance with valid attributes' do
    @user.ingredients.create!(@attr)
  end
  
  describe 'user association' do
  
    before(:each) do
      @ingredient = @user.ingredients.create(@attr)
    end
    
    it 'should have a user attribute' do
      @ingredient.should respond_to(:user)
    end
    
    it 'should have the right associated user' do
      @ingredient.user_id.should == @user.id
      @ingredient.user.should == @user
    end
  end

  describe 'validations' do
    
    it 'should have a user id' do
      Ingredient.new(@attr).should_not be_valid
    end
    
    it 'should require a nonblank name' do
      @user.ingredients.build(:name => "   ").should_not be_valid
    end
    
    it 'should reject a long name' do
      @user.ingredients.build(:name => 'a'*51).should_not be_valid
    end
  end
end
