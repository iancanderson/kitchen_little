class Ingredient < ActiveRecord::Base
  belongs_to :user

  validates :name, :length => { :minimum => 1}
end
