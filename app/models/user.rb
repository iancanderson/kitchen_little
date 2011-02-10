class User < ActiveRecord::Base
  has_many  :ingredients, :dependent => :destroy
  has_many  :recipes, :dependent => :destroy
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  def kitchen_efficiency_score
    if ingredients.empty? or recipes.empty?
      return 0
    end
    # this formula gives a score between 0 and 100
    x = recipes.count.to_f / ingredients.count.to_f
    200 * Math.atan(x / 3) / Math::PI
  end
end
