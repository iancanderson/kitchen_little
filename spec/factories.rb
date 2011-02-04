# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :user do |user|
  user.sequence(:email) { |n| "user#{n}@example.com" }
  user.password "password"
end

Factory.define :ingredient do |ingredient|
  ingredient.sequence(:name) { |n| "ingredient#{n}" }
  ingredient.user
end
