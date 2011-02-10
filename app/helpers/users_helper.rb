module UsersHelper

  def possessive_pronoun_for_user
    current_user == @user ? "My" : "#{@user.email}'s"
  end
end
