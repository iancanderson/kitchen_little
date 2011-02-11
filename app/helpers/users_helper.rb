module UsersHelper

  def possessive_pronoun_for_user
    current_user == @user ? "My" : "#{@user.username}'s"
  end
end
