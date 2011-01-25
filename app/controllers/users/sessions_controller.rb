class Users::SessionsController < Devise::SessionsController
  def new
    @title = "Sign in"
  end
end
