# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :user do |user|
  user.email    "anderson.ian.c@gmail.com"
  user.password "password"
end

Factory.define :ingredient do |ingredient|
  ingredient.name "garlic"
  ingredient.user_id 1
end
