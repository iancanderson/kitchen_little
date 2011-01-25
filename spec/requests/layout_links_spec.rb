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
  
  it "should have the right links on the layout" do
    visit root_path
    click_link "Home"
    response.should have_selector('title', :content => "Home")
    click_link "About"
    response.should have_selector('title', :content => "About")
    click_link "Sign in"
    response.should have_selector('title', :content => "Sign in")
  end
end
