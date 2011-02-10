class UsersController < ApplicationController
  include UsersHelper
  def show
    @user = User.find(params[:id])
    @title = "#{possessive_pronoun_for_user} Kitchen"
  end
end
