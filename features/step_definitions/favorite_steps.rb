Given /^that user has favorited that recipe$/ do
  @user.favorites.create(user: @user, recipe: @recipe)
end

When /^I click the favorite button$/ do
  find(".favorite > form > div > input").click
end

When /^I click the unfavorite button$/ do
  find(".unfavorite > form > div > input").click
end

Then /^I should have that recipe favorited$/ do
  @user.favorites.find_by_id(@recipe).try(:recipe_id).should eq(@recipe.id)
end

Then /^I should no longer have that recipe favorited$/ do
  @user.favorites.find_by_id(@recipe).try(:recipe_id).should_not eq(@recipe.id)
end

Then /^I cannot see the favorite button$/ do
  page.should_not have_selector(".favorite")
end

Then /^I can see the favorite button$/ do
  page.should have_selector(".favorite")
end

Then /^I cannot see the unfavorite button$/ do
  page.should_not have_selector(".unfavorite")
end

Then /^I can see the unfavorite button$/ do
  page.should have_selector(".unfavorite")
end
