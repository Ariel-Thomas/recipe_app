Feature: User actions
      
  Scenario: Profile page shows submissions
    Given a user exists in the database
    And a recipe exists in the database created by that user
    When I visit that user's profile page
    Then I should see that recipe

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

  Scenario: User's edit page is restricted from other users
    Given a user exists in the database
    When I visit that user's edit page
    Then I am redirected to the login page

  Scenario: User's update action is restricted from other users
    Given a user exists in the database
    When I send that user an update request
    Then I am redirected

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

  Scenario: User's destroy action is restricted from other users
    Given a user exists in the database
    When I send that user a destroy request
    Then I am redirected