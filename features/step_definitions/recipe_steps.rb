Given /^a user visits the new recipe page$/ do
  visit new_recipe_path
end

When /^he submits invalid recipe information$/ do
  click_button "Submit"
end

Then /^he should see an error message$/ do
  page.should have_selector('div.alert.alert-error')
end

When /^he submits valid recipe information$/ do
  fill_in "Name",         with: "Cookies"
  fill_in "Description",  with: "Delicious Cookies"
  click_button "Submit"
end

Then /^he should create a new recipe$/ do
 Recipe.count.should eq(1)
end

Then /^he should see a success message$/ do
  page.flash[:success].should =~ /created/
end
