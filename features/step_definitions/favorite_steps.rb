Given /^that user has favorited the recipe$/ do
  @user.favorites.create!(recipe: @recipe)
end

When /^I click the favorite button$/ do
  click_button "favorite"
end

When /^I click the unfavorite button$/ do
  click_button "unfavorite"
end

Then /^I should have the recipe favorited$/ do
  @user.favorites.find(@recipe).should eq(@recipe)
end

Then /^I should no longer have the recipe favorited$/ do
  @user.favorites.find(@recipe).should_not eq(@recipe)
end

Then /^I cannot see the favorite button$/ do
  page.should_not have_selector("button", id: "favorite")
end

Then /^I can see the favorite button$/ do
  page.should have_selector("button", id: "favorite")
end

Then /^I cannot see the unfavorite button$/ do
  page.should_not have_selector("button", id: "unfavorite")
end

Then /^I can see the unfavorite button$/ do
  page.should have_selector("button", id: "unfavorite")
end
