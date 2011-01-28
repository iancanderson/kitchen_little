require 'spec_helper'

describe UsersController do
  render_views

  before(:each) do
    @user = Factory(:user)
    @ing1 = Factory(:ingredient, :user_id => @user)
    @ing2 = Factory(:ingredient, :user_id => @user)
  end

  describe "GET 'show'" do
    
    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end
    
    it 'should find the right user' do
      get :show, :id => @user
      assigns(:user).should == @user
    end    

    it "should show the user's list of ingredients" do
      get :show, :id => @user
      response.should have_selector("div#ingredients")
      response.should have_selector("div", :content => @ing1.name)
      response.should have_selector("div", :content => @ing2.name)
    end
    
    describe 'user signed in' do
      
      before(:each) do
        sign_in @user
      end
      
      it 'should show the new ingredient form' do
        get :show, :id => @user
        response.should have_selector("form", :id => "new_ingredient")
      end
      
      it "should show a delete link next to each ingredient" do
        get :show, :id => @user
        response.should have_selector("a", :content => "delete")
      end
    end
    
    describe 'user not signed in' do
      
      it 'should not show the new ingredient form' do
        get :show, :id => @user
        response.should_not have_selector("form", :id => "new_ingredient")
      end
    end
  end
end
