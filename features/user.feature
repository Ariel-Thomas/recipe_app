Feature: User authentication

  Scenario: Try to sign up with invalid information
    Given I visit the sign up page
    When I enter invalid sign up information
    And click the create user button
    Then a user should not be created
    And I should see the sign up page
    And I should see an error message

  Scenario: Sign up with valid information
    Given I visit the sign up page
    When I enter valid sign up information
    And click the create user button
    Then a user should be created 
    And I should not see the sign up page    
    And I should see a success message

  Scenario: Sign in with invalid information
    Given a user exists in the database
    And I visit the sign in page
    When I enter invalid sign in information
    And click the sign in button
    Then I should see I am not signed in
    And I should see the sign in page    
    And I should see an invalid sign in message

  Scenario: Sign in with valid information
    Given a user exists in the database
    And I visit the sign in page
    When I enter valid sign in information
    And click the sign in button
    Then I should see I am signed in
    And I should not see the sign in page    
    And I should see a success message

  Scenario: Signing out
    Given a user exists in the database
    And I am logged in
    When I click the sign out link
    Then I should see I am not signed in
    And I should see a success message

  Scenario: Edit User with invalid information
    Given a user exists in the database
    And I am logged in
    And I visit my user page
    When I click the edit link
    And I input invalid password changes
    And I click the update user button
    Then I should see the edit user page
    And I should see an error message

  Scenario: Edit User with valid information
    Given a user exists in the database
    And I am logged in
    And I visit my user page
    When I click the edit link
    And I input valid password changes
    And I click the update user button
    Then I should see the user page
    And I should see a success message
    And I should be able to log back in with the new password

  @javascript
  Scenario: User destroys self
    Given a user exists in the database
    And I am logged in
    And I visit my user page
    When I click the edit link
    And I click the delete link
    Then I should see the recipes index
    And I should see a success message
    And the user should be deleted

  Scenario: Profile page shows submitted recipes
    Given a user exists in the database
    And a recipe exists in the database created by that user
    When I visit that user's profile page
    Then I should see the recipe