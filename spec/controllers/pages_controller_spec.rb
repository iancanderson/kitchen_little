require 'spec_helper'

describe PagesController do
  render_views

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
