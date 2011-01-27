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
    
    before(:each) do
      visit user_path(@user)
      fill_in :name, :with => "onions"
      click_button
      click_link "delete"
    end
    
    it "should delete the ingredient from the list" do
      visit user_path(@user)
      response.should_not have_selector("li.ingredient")
    end
  end
end
