Given /^I visit any page$/ do
  visit root_path
end

When /^I click the recipes link$/ do
  click_link "Recipes"
end

Then /^I should see the recipes index$/ do
  page.should have_selector('h1', text: "Recipe Index")
end

When /^I click the new recipe link$/ do
  click_link "New Recipe"
end

Then /^I should see the new recipe page$/ do
  page.should have_selector('h1', text: "New Recipe")
end

When /^I click the sign up link$/ do
  click_link "Sign Up"
end

Then /^I should see the sign up page$/ do
  page.should have_selector('h1', text: "Sign Up")
end
