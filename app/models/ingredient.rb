class Ingredient < ActiveRecord::Base
  belongs_to :user

  validates :name,  :presence => true,
            :length => { :maximum => 50 },
            :uniqueness => { :scope => :user_id }
  validates :user_id, :presence => true
  
  default_scope :order => 'ingredients.created_at DESC'

end
