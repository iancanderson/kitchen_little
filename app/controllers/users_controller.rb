class UsersController < ApplicationController #Devise::UsersController
  
  def show 
    @user = User.find(params[:id])
  end
end
