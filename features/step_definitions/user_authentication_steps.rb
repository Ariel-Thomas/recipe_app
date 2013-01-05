When /^I choose to sign in with facebook$/ do
  click_link "facebook-login"
end

When /^I enter valid facebook sign in information$/ do
  fill_in "email", with: ENV['FACEBOOK_TEST_EMAIL']
  fill_in "pass", with: ENV['FACEBOOK_TEST_PASSWORD']
end

When /^I enter invalid facebook sign in information$/ do
  fill_in "email", with: ""
  fill_in "pass", with: ""
end

When /^click the login button$/ do
  click_button "Log In"
end
