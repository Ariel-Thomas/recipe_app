Given /^I visit the new recipe page$/ do
  visit new_recipe_path
end

When /^I submit invalid recipe information$/ do
  click_button "Submit"
end

Then /^I should see an error message$/ do
  page.should have_selector('div.alert.alert-error')
end

Then /^I should return to the new page$/ do
  page.should have_selector('h1', text: "New Recipe")
end

When /^I submit valid recipe information$/ do
  fill_in "Name",         with: "Cookies"
  fill_in "Description",  with: "Delicious Cookies"
  click_button "Submit"
end

Then /^I should see a new recipe created$/ do
  Recipe.count.should eq(1)
end

Then /^I should see a success message$/ do
  page.should have_selector('div.alert.alert-success')
end


Given /^a recipe exists in the database$/ do
  @recipe = Recipe.create(name: "Cookies", description: "Delicious Cookies")
  end

Given /^I visit the index page$/ do
  visit recipes_path
end

Then /^I should see the recipe$/ do
  Recipe.count.should eq(1)
  page.should have_content(@recipe.name)
end

When /^I click the delete link$/ do
  click_link "delete"
end

Then /^I should see the recipe removed$/ do
  Recipe.count.should eq(0)
  page.should_not have_content("Cookies")
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
end

When /^I click the edit link$/ do
  click_link "edit"
end

Then /^I should see the recipe's edit page$/ do
  page.should have_selector('h1', text: "Edit Recipe")
end
