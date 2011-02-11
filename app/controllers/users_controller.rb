class UsersController < ApplicationController
  include UsersHelper
  def show
    @user = User.find_by_username(params[:id])
    @title = "#{possessive_pronoun_for_user} Kitchen"
  end
end
