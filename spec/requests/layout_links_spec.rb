require 'spec_helper'

describe "LayoutLinks" do
  
  it "should have a Home page at '/'" do
    get '/'
    response.should have_selector("title", :content => "Home")
  end
  
  it "should have an About page at '/about'" do
    get '/about'
    response.should have_selector("title", :content => "About")
  end
  
  it "should have a Sign in page at '/users/sign_in'" do
    get 'users/sign_in'
    response.should have_selector("title", :content => "Sign in")
  end
  
  it "should have a Sign up page at '/signup'" do
    get '/signup'
    response.should have_selector("h2", :content => "Sign up")
  end
  
  it "should have the right links on the layout" do
    visit root_path
    click_link "Home"
    response.should have_selector('title', :content => "Home")
    click_link "About"
    response.should have_selector('title', :content => "About")
    click_link "Sign in"
    response.should have_selector('title', :content => "Sign in")
  end
  
  describe "when not signed in" do
    
    it "should have a sign in link" do
      visit root_path
      response.should have_selector("a",  :href => signin_path,
                                          :content => "Sign in")
    end
  end
  
  describe "when signed in" do
    
    before(:each) do
      @user = Factory(:user)
      visit signin_path
      fill_in :login,     :with => @user.email
      fill_in :password,  :with => @user.password
      click_button
    end
    
    it "should have a signout link" do
      visit root_path
      response.should have_selector("a",  :href => signout_path,
                                          :content => "Sign out")
    end
    
    it "should have a My Kitchen link" do
      visit root_path
      response.should have_selector("a",  :href => user_path(@user),
                                          :content => "My Kitchen")
    end
  end
end
