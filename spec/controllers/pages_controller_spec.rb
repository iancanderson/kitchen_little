require 'spec_helper'

describe PagesController do
  render_views

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end

    it 'should have the right title' do
      get 'home'
      response.should have_selector("title", :content => "Kitchen Little | Home")
    end
    
    describe "when not signed in" do
      it "should show the signup button" do
        get 'home'
        response.should have_selector("a",  :content => "Sign up now!",
                                            :class => "signup_button round")
      end
    end
    
    describe "when signed in" do
      
      before(:each) do
        @user = Factory(:user)
        sign_in @user
      end
      
      it "should not show the signup button'" do
        get :home
        response.should_not have_selector("a",  :content => "Sign up now!")
      end
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end

    it 'should have the right title' do
      get 'about'
      response.should have_selector("title", :content => "Kitchen Little | About")
    end
  end

end
