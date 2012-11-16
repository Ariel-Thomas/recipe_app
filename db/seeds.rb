# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Admin
admin = User.create(
  username: "admin",
  email: "admin@derp.com",
  password: "admin",
  password_confirmation: "admin",
  about_me: "I am an admin",
  admin: true
  )


#User
user = User.create(
  username: "Herp",
  email: "herp@derp.com",
  password: "derp",
  password_confirmation: "derp",
  about_me: "I am a user and I like to have fun."
  )

#Cookies
recipe = Recipe.create(
  name: "Cookies",
  description: "delicious cookies",
  user: user,
  ingredient_entries: Recipe.parse_and_create_ingredients("1 C Sugar\n1 C Flour\n2 T Butter")
  )

direction = recipe.directions.create!(title: "Combine", text: "Combine the dry ingredients", ingredient_entries: Array([recipe.ingredient_entries[0], recipe.ingredient_entries[1]]))
recipe.add_result_for direction

direction = recipe.directions.create!(title: "Cream", text: "Cream the butter with a mixer", ingredient_entries: Array(recipe.ingredient_entries[2]))
recipe.add_result_for direction

direction = recipe.directions.create!(title: "Mix and Bake 350 for 10 min", text: "Mix the wet and dry ingredients until they reach a smooth consistency.  Place on a cookie sheet and bake at 350 for 10 min.", ingredient_entries: Array([recipe.ingredient_entries[3], recipe.ingredient_entries[4]]))
recipe.add_result_for direction


#Tugboat turnips

recipe = Recipe.create(
  name: "Tugboat Turnips",
  description: "Have been making this tasty side since I saw Paula make it many years ago. Is always requested for family gatherings, especially Thanksgiving. Didn't change a thing.",
  user: user,
  ingredient_entries: Recipe.parse_and_create_ingredients("2 large rutabagas, or turnips\n6 large carrots\n1 cup butter\n1 cup light brown sugar\n1 teaspoon salt")
  )

direction = recipe.directions.create!(title: "Peel and chop", text: "Peel and chop the rutabagas and carrots.", ingredient_entries: Array([recipe.ingredient_entries[0], recipe.ingredient_entries[1]]))
recipe.add_result_for direction

direction = recipe.directions.create!(title: "Boil until tender", text: "Place in a medium size saucepan, cover with water, and bring to a boil. Gently cook until tender.", ingredient_entries: Array(recipe.ingredient_entries[5]))
recipe.add_result_for direction

direction = recipe.directions.create!(title: "Mix", text: "Drain the rutabagas and carrots, add the butter and brown sugar.", ingredient_entries: Array([recipe.ingredient_entries[2], recipe.ingredient_entries[3], recipe.ingredient_entries[6]]))
recipe.add_result_for direction

direction = recipe.directions.create!(title: "Mash", text: "Mash with a potato masher. Adjust the taste with salt.", ingredient_entries: Array([recipe.ingredient_entries[4], recipe.ingredient_entries[7]]))
recipe.add_result_for direction

#Cake

recipe = Recipe.create(
  name: "Cake",
  description: "Delicious Cake",
  user: user,
  ingredient_entries: Recipe.parse_and_create_ingredients("2 T Chocolate\n2 C Water\n5 C Awesomesauce\n4 C Flour\n2 T Butter")
  )

direction = recipe.directions.create!(title: "Mix", text: "Mix dry ingredients", ingredient_entries: Array([recipe.ingredient_entries[0], recipe.ingredient_entries[1]]))
recipe.add_result_for direction

direction = recipe.directions.create!(title: "Cream in butter", text: "Mix the butter in with a mixer.", ingredient_entries: Array([recipe.ingredient_entries[4], recipe.ingredient_entries[5]]))
recipe.add_result_for direction

direction = recipe.directions.create!(title: "Mix", text: "Mix wet ingredients", ingredient_entries: Array([recipe.ingredient_entries[2], recipe.ingredient_entries[3]]))
recipe.add_result_for direction

direction = recipe.directions.create!(title: "Bake at 350 for 30 min", text: "Put it all in a square baking dish and bake at 350F for 30 minutes.", ingredient_entries: Array([recipe.ingredient_entries[6], recipe.ingredient_entries[7]]))
recipe.add_result_for direction

#random recipes
50.times do |index|
  user = User.create(
  username: "User" + index.to_s,
  email: "user" + index.to_s + "@derp.com",
  password: "derp",
  password_confirmation: "derp"
  )

  recipe = Recipe.create(
    name: "Recipe" + index.to_s,
    description: "Random Description",
    user: user,
    ingredient_entries: Recipe.parse_and_create_ingredients("2 C Nothing")
    )
end