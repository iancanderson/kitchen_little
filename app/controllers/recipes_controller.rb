class RecipesController < ApplicationController  

  def create
    @user = User.find(params[:user_id])
    @recipe = @user.recipes.build(params[:recipe])
    @recipe.save
    respond_to do |format|
      format.html { redirect_to user_path(params[:user_id]) }
      format.js
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to user_path(params[:user_id]) }
      format.js
    end
  end
end
