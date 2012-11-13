Given /^I visit the sign up page$/ do
  visit new_user_path
end

When /^I enter invalid sign up information$/ do
  fill_in "Username",         with: "Empty String"  
end

When /^I enter valid sign up information$/ do
  fill_in "Username",               with: "TestUser" 
  fill_in "Email",                  with: "Test@user.com"
  fill_in "Password",               with: "derp"
  fill_in "Password confirmation",  with: "derp"
end

When /^click the create user button$/ do
  click_button 'Create User'
end

Then /^a user should not be created$/ do
  User.count.should eq(0)
end

Then /^a user should be created$/ do
  page.should have_content "Signed up!"
  User.count.should eq(1)
end

Then /^I should not see the sign up page$/ do
  page.should_not have_selector('h1', text: "Sign Up")
end

Given /^a user exists in the database$/ do
  @user = User.create!(username: "TestUser", email: "Test@user.com", password: "derp", password_confirmation: "derp");
end

Given /^I visit the sign in page$/ do
  visit new_session_path
end

When /^I enter invalid sign in information$/ do
  fill_in "Username",               with: "TestUser" 
  fill_in "Password",               with: ""
end

When /^I enter valid sign in information$/ do
  fill_in "Username",               with: "TestUser" 
  fill_in "Password",               with: "derp"
end

When /^click the sign in button$/ do
  click_button "Sign In"
end

Then /^I should see I am not signed in$/ do
  page.should_not have_selector('li', text: "Sign Out")
end

Then /^I should see I am signed in$/ do
  page.should have_selector('li', text: "Sign Out")
end

Then /^I should see the sign in page$/ do
  page.should have_selector('h1', text: "Sign In")
end

Then /^I should not see the sign in page$/ do
  page.should_not have_selector('h1', text: "Sign In")
end

Then /^I should see an invalid sign in message$/ do
  page.should have_content("Username or password was invalid.")
end


Given /^I am logged in$/ do
  visit new_session_path
  fill_in "Username",               with: "TestUser" 
  fill_in "Password",               with: "derp"
  click_button "Sign In"
end

When /^I click the sign out link$/ do
  click_link "Sign Out"
end

Given /^I visit my user page$/ do
  click_link 'TestUser'
end

When /^I click the update user button$/ do
  click_button "Update User"
end

When /^I input invalid password changes$/ do
  fill_in "Password",               with: ""
  fill_in "Password confirmation",  with: "herp"
end

When /^I input valid password changes$/ do
  fill_in "Password",               with: "herp"
  fill_in "Password confirmation",  with: "herp"
end

Then /^I should see the edit user page$/ do
  page.should have_selector('h1', text: "Edit TestUser's Profile")
end

Then /^I should see the user page$/ do
  page.should have_selector('h1', text: "TestUser's Profile")
end

Then /^I should be able to log back in with the new password$/ do
  click_link "Sign Out"
  click_link "Sign In"
  fill_in "Username",               with: "TestUser" 
  fill_in "Password",               with: "herp"
  click_button "Sign In"
end