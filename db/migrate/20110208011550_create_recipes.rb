class CreateRecipes < ActiveRecord::Migration
  def self.up
    create_table :recipes do |t|
      t.string :link_url
      t.string :link_name
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :recipes
  end
end
