Given /^I visit the new recipe page$/ do
  @num_recipes_before_create = Recipe.count
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
  Recipe.count.should eq(@num_recipes_before_create + 1)
end

Then /^I should see a success message$/ do
  page.should have_selector('div.alert.alert-success')
end

Given /^a recipe exists in the database$/ do
  #Recipe.all.map!{ |recipe| recipe.destroy }
  @num_recipes_before_create = Recipe.count

  @recipe = Recipe.create!(name: "Cookies", description: "Delicious", ingredient_entries: Recipe.parse_and_create_ingredients("1 C Sugar\n1 C Flour\n2 T Butter"))
end

Given /^I visit the index page$/ do
  visit recipes_path
end

Then /^I should see that recipe$/ do
  page.should have_content(@recipe.name)
end

Then /^I should not see a delete link$/ do
  page.should_not have_selector('a', text: "delete")
end

When /^I click the delete link$/ do
  popup.confirm{ click_link "delete" }
end

Then /^I should see the recipe removed$/ do
  Recipe.count.should eq(@num_recipes_before_create)
end

When /^I click the recipe's link$/ do
  click_link "Cookies"
end

Then /^I should see the recipe's page$/ do
  page.should have_selector('h1', text: "Cookies")
end

Given /^I visit that recipe's edit page$/ do
  visit edit_recipe_path(@recipe)
end

When /^I change the description$/ do
  fill_in "Description",  with: "Something silly"
end

Then /^I should not see an edit link$/ do
  page.should_not have_selector('a', text: "edit")
end

When /^I click the edit button$/ do
  click_button "Edit"
end

Then /^I should see the description has changed$/ do
  page.should have_content("Something silly")
end

When /^I visit that recipe's show page$/ do
  visit recipe_path(@recipe)
end

Then /^I should see that recipe's information$/ do
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

When /^I enter that recipe's name in the search$/ do
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
  @num_recipes_before_create = Recipe.count

  num_recipes.to_i.times do |index|
    @recipe = Recipe.create!(name: "Recipe" + index.to_s, description: "Delicious", ingredient_entries: Recipe.parse_and_create_ingredients("2 C Nothing"))
  end

end

Then /^I should not see that last recipe$/ do
  page.should_not have_content(@recipe.name)
end


When /^I attach a valid picture$/ do
  attach_file("recipe_picture", File.expand_path("app/assets/images/rails.png"))
end

Then /^I should see the picture$/ do
  page.should have_selector('img', alt: 'Rails')
end

Given /^a picture is attached to that recipe$/ do
  @recipe.update_attributes(picture: File.open("app/assets/images/rails.png"))
end

When /^I attach an invalid picture$/ do
  begin
    attach_file("recipe_picture", File.expand_path("app/assets/images/invalid"))
  rescue
  end
end

Then /^I should not see the picture$/ do
  page.should_not have_selector('img', alt: 'Invalid')
end

