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
      get :show, :id => @user.username
      response.should be_success
    end
    
    it 'should find the right user' do
      get :show, :id => @user.username
      assigns(:user).should == @user
    end    

    it "should show the user's list of ingredients" do
      get :show, :id => @user.username
      response.should have_selector("div#ingredients")
      response.should have_selector("div", :content => @ing1.name)
      response.should have_selector("div", :content => @ing2.name)
    end
    
    describe 'user signed in' do
      
      before(:each) do
        sign_in @user
      end
      
      it 'should show the new ingredient form' do
        get :show, :id => @user.username
        response.should have_selector("form", :id => "new_ingredient")
      end
      
      it "should show a delete link next to each ingredient" do
        get :show, :id => @user.username
        response.should have_selector("a", :content => "delete")
      end
    end
    
    describe 'user not signed in' do
      
      it 'should not show the new ingredient form' do
        get :show, :id => @user.username
        response.should_not have_selector("form", :id => "new_ingredient")
      end
    end
  end

  describe "GET 'index'" do
    it "should be successful" do
      get :index
      response.should be_success
    end

    it 'should have the right title' do
      get :index
      response.should have_selector("title", :content => "Kitchen Little | Home")
    end

    describe "when not signed in" do
      it "should show the signup button" do
        get :index
        response.should have_selector("a",  :content => "Sign up now!",
                                            :href => new_user_registration_path)
      end
    end

    describe "when signed in" do

      before(:each) do
        @user = Factory(:user)
        sign_in @user
      end

      it "should not show the signup button'" do
        get :index
        response.should_not have_selector("a",  :content => "Sign up now!")
      end
    end
  end
end
