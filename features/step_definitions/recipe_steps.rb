Given /^I visit the new recipe page$/ do
  visit new_recipe_path
end

When /^I click the done button$/ do
  click_link "Done"
end

Then /^I should see an error message$/ do
  page.should have_selector('div.alert.alert-error')
end

Then /^I should return to the new page$/ do
  page.should have_selector('h1', text: "New Recipe")
end

When /^I input valid recipe information$/ do
  fill_in "Name",         with: "Cookies"
  fill_in "Description",  with: "Delicious Cookies"
  fill_in "Ingredients",  with: "1 C Sugar\n1 C Flour\n2 T Butter"
end

When /^I poorly format the ingredients$/ do
  fill_in "Ingredients", with: "1 C Sugar\n\n1 C Flour                      \n2 T Butter"
end

Then /^I should see ingredients properly formatted$/ do
  page.should have_selector('li', text: "1 C Sugar")
  page.should have_selector('li', text: "1 C Flour")
  page.should have_selector('li', text: "2 T Butter")
end

Then /^I should see a new recipe created$/ do
  Recipe.count.should eq(1)
end

Then /^I should see a success message$/ do
  page.should have_selector('div.alert.alert-success')
end

Given /^a recipe exists in the database$/ do
  Recipe.all.map!{ |recipe| recipe.destroy }

  @number_of_recipes_in_database_before = Recipe.count

  @recipe = Recipe.create!(name: "Cookies", description: "Delicious", ingredient_entries: Recipe.parse_and_create_ingredients("1 C Sugar\n1 C Flour\n2 T Butter"))

  Recipe.count.should eq(@number_of_recipes_in_database_before + 1)

  Recipe.reindex
end

Given /^I visit the index page$/ do
  visit recipes_path
end

Then /^I should see the recipe$/ do
  page.should have_content(@recipe.name)
end

When /^I click the delete link$/ do
  popup.confirm{ click_link "delete" }
end

Then /^I should see the recipe removed$/ do
  Recipe.count.should eq(@number_of_recipes_in_database_before)
end

When /^I click the recipe's link$/ do
  click_link "Cookies"
end

Then /^I should see the recipe's page$/ do
  page.should have_selector('h1', text: "Cookies")
end

Given /^I visit the recipe's edit page$/ do
  visit edit_recipe_path(@recipe)
end

When /^I change the description$/ do
  fill_in "Description",  with: "Something silly"
end

When /^I click the edit button$/ do
  click_button "Edit"
end

Then /^I should see the description has changed$/ do
  page.should have_content("Something silly")
end

When /^I visit the recipe's show page$/ do
  visit recipe_path(@recipe)
end

Then /^I should see the recipe's information$/ do
  page.should have_content(@recipe.name)
  page.should have_content(@recipe.description)
  @recipe.ingredients_array.each{ |ingredient| page.should have_selector('li', text: ingredient) }
  @recipe.directions_array.each{ |direction| page.should have_content(direction) }
end

When /^I click the edit link$/ do
  click_link "edit"
end

Then /^I should see the recipe's edit page$/ do
  page.should have_selector('h1', text: "Edit Recipe")
end

When /^I enter the recipe name in the search$/ do
  fill_in "Search",     with: @recipe.name
end

When /^I click the search button$/ do
  click_button "Search"
end

When /^I click the next button$/ do
  click_button "Next"
end

When /^I enter valid recipe directions$/ do
  check "direction_ingredient_entries_0"
  fill_in "direction_text",  with: "Mix all ingredients together with blender"
end

When /^I click the add new direction button$/ do
  click_button "Add New Direction"
end

When /^I click the add direction button$/ do
  click_button "Add Direction"
end