# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :user do |user|
  user.sequence(:username) { |n| "user#{n}" }
  user.sequence(:email) { |n| "user#{n}@example.com" }
  user.password "password"
end

Factory.define :ingredient do |ingredient|
  ingredient.sequence(:name) { |n| "ingredient#{n}" }
  ingredient.association :user
end

Factory.define :recipe do |recipe|
  recipe.sequence(:link_url)  { |n| "http://www.example.com/Recipe/#{n}" }
  recipe.sequence(:link_name) { |n| "Recipe #{n}" }
  recipe.association :user
end
