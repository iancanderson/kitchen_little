class RecipesController < ApplicationController  

  def create
    @user = User.find(params[:user_id])
    @recipe = @user.recipes.build(params[:recipe])
    @recipe.save
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
  end

end
