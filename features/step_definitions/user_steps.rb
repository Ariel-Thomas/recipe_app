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
  @num_users_before_create = User.count

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

Then /^the user should be deleted$/ do
  User.count.should eq(@num_users_before_create)
end

Given /^a recipe exists in the database created by that user$/ do
  @num_recipes_before_create = Recipe.count

  @recipe = Recipe.create!(name: "Cookies", description: "Delicious",user: @user, ingredient_entries: Recipe.parse_and_create_ingredients("1 C Sugar\n1 C Flour\n2 T Butter"))
end

When /^I visit that user's profile page$/ do
  visit user_path(@user)
end

When /^I visit that user's edit page$/ do
  visit edit_user_path(@user)
end

Then /^I am redirected to the login page$/ do
  page.should have_selector('h1', text: "Sign In")
end

Then /^I am redirected$/ do
  page.should_not have_content("User");
  page.should_not have_content("Recipe");
end

When /^I send an update request$/ do
  put user_path(@user)
end

When /^I send a destroy request$/ do
  delete user_path(@user)
end

Then /^I should see my edit page$/ do
  page.should have_selector('h1', text: "Edit TestUser's Profile")
end

When /^I delete the user$/ do
  @user.destroy
end

Then /^I should see the deleted user's username$/ do
  page.should have_content "TestUser"
end

Given /^an admin exists in the database$/ do
  @admin = User.create!(username: "admin", email: "admin@user.com", password: "admin", password_confirmation: "admin", admin: true);
end

Given /^I am logged in as an admin$/ do
  visit new_session_path
  fill_in "Username",               with: "admin" 
  fill_in "Password",               with: "admin"
  click_button "Sign In"
end

When /^I input valid email changes$/ do
  fill_in "Email",                  with: "changed@user.com"
end

Then /^the email should be changed$/ do
  User.find(@user.id).email.should eq("changed@user.com")
end

Then /^I should see an avatar$/ do
  page.should have_selector('img',class: 'avatar')
end

Given /^that user has an email linked to a valid gravatar account$/ do
  @user.update_attributes(email: "Ariel.Thomas@gmail.com")
end

Then /^I should see that gravatar$/ do
  gravatar_id = Digest::MD5.hexdigest(@user.email.downcase)
  page.should have_selector("img", src: "http://gravatar.com/avatar/#{gravatar_id}.png?s=80")
end

Given /^that user has a link to an image$/ do
  @user.update_attributes(avatar_url: "http://goonlol.com/images/c/c8/Icon_Jax.jpg")
end

Then /^I should see the image$/ do
  page.should have_selector("img", src: "http://goonlol.com/images/c/c8/Icon_Jax.jpg")
end

When /^I input valid avatar information$/ do
  fill_in "Avatar",               with: "http://goonlol.com/images/c/c8/Icon_Jax.jpg" 
end