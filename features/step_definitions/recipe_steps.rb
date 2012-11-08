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
  @recipe.ingredient_entries.each{ |entry| page.should have_selector('li', text: entry.to_s) if (entry.direction.present?) }
  @recipe.directions.each{ |direction| page.should have_content(direction) }
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

Then /^I should still be on the recipe's show page$/ do
  page.should have_selector('h1', text: @recipe.name)
end

Given /^(\d+) recipes exist in the database$/ do |num_recipes|
  num_recipes.times do |index|
    @recipe = Recipe.create!(name: "Recipe" + index.to_s, description: "Delicious", ingredient_entries: Recipe.parse_and_create_ingredients("2 C Nothing"))
  end

end

Then /^I should not see the last recipe$/ do
  page.should_not have_content(@recipe.name)
end
