require 'spec_helper'

describe UsersController do
  render_views

  before(:each) do
    @user = Factory(:user)
  end

  describe "GET 'show'" do
    it "should be successful" do
      get 'show', :id => @user
      response.should be_success
    end
    
    it 'should find the right user' do
      get :show, :id => @user
      assigns(:user).should == @user
    end
  end
end
