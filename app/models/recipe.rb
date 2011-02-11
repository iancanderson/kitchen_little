class Recipe < ActiveRecord::Base
  belongs_to :user

  validates :link_url,
            :uniqueness => { :scope => :user_id }
  validates :link_name,
            :presence => true,
            :uniqueness => { :scope => :user_id}

  default_scope :order => 'recipes.created_at DESC'
end
