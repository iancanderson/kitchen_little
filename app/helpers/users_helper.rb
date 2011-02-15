module UsersHelper

  def possessive_pronoun_for_user
    current_user == @user ? "My" : "#{@user.username}'s"
  end

  def recipe_puppy_link(user)
    comma_separated_ingredients = ""
    user.ingredients.each do |ingredient|
      comma_separated_ingredients += ingredient.name + ","
    end
    "http://www.recipepuppy.com/?i=#{comma_separated_ingredients}"
  end
end
