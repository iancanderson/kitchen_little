require 'spec_helper'

describe "Ingredients" do

  before(:each) do
    @user = Factory(:user)
    visit signin_path
    fill_in :email,     :with => @user.email
    fill_in :password,  :with => @user.password
    click_button
  end
  
  describe "deletion" do
    it "can be deleted by their owner"
    it "can't be deleted by unauthorized users"
  end
  
  describe "creation" do
    it "can be created by their owner"
    it "can't be created by unauthorized users"
    it "should show an error message when validation fails"
  end
end
