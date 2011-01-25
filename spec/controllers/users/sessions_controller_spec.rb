require 'spec_helper'

describe Users::SessionsController do
  render_views
  
  before(:each) do
    # see http://www.lostincode.net/blog/testing-devise-controllers
    request.env["devise.mapping"] = Devise.mappings[:user]
  end
  
  describe "GET 'new'" do

    it "should have the right title" do
      get :new
      response.should have_selector("title", :content => "Sign in")      
    end
  end
end
