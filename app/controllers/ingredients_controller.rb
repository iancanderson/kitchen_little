class IngredientsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @ingredient = @user.ingredients.build(params[:ingredient])
    @ingredient.save    
    redirect_to @user
  end

  def destroy
    @ingredient = Ingredient.find(params[:id])
    @ingredient.destroy! unless @ingredient == nil?
  end

end
