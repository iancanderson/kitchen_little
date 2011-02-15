class UsersController < ApplicationController
  include UsersHelper
  def show
    @user = User.find_by_username(params[:id])
    @title = "#{possessive_pronoun_for_user} Kitchen"
  end

  def index
    @title = "Home"
    @users = User.all
    #TODO: this is icky. should we cache these calcs in the user model?
    #sort by efficiency score, descending
    @users.sort! { |a, b| b.kitchen_efficiency_score <=> a.kitchen_efficiency_score }
  end
end
