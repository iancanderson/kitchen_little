class IngredientsController < ApplicationController
  
  def create
    @user = User.find(params[:user_id])
    @ingredient = @user.ingredients.build(params[:ingredient])
    @ingredient.save
    respond_to do |format|
      format.html { redirect_to user_path(params[:user_id]) }
      format.js
    end
  end

  def destroy
    @ingredient = Ingredient.find(params[:id])
    @ingredient.destroy
    respond_to do |format|
      format.html { redirect_to user_path(params[:user_id]) }
      format.js
    end
  end
end
