require 'spec_helper'

describe IngredientsController do

  describe "POST 'create'" do
    
    before(:each) do
      @user = Factory(:user)
      sign_in @user
    end
    
    describe 'failure' do
      
      before(:each) do
        @attr = { :name => ""}
      end
      
      it 'should not create an ingredient' do
        lambda do
          post :create, :ingredient => @attr, :user_id => @user.id
        end.should_not change(Ingredient, :count)
      end
      
      it 'should redirect to the user show page' do
        post :create, :ingredient => @attr, :user_id => @user.id
        response.should redirect_to @user
      end
    end

    describe 'success' do
      
      before(:each) do
        @attr = { :name => "garlic"}
      end
      
      it 'should create an ingredient' do
        lambda do
          post :create, :ingredient => @attr, :user_id => @user.id
        end.should change(Ingredient, :count).by(1)
      end
      
      it 'should associate the new ingredient with the correct user' do
        lambda do
          post :create, :ingredient => @attr, :user_id => @user.id
        end.should change(@user.ingredients, :count).by(1)
      end
      
      it 'should redirect to the user show page' do
        post :create, :ingredient => @attr, :user_id => @user.id
        response.should redirect_to @user
      end
    end
  end

  describe "DELETE 'destroy'" do

  end
end
