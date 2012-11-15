@http://www.pivotaltracker.com/story/show/39625045
Feature: As an admin, I can manage any other users and their pages.

  Scenario: Admin edit user
    Given an admin exists in the database
    And I am logged in as an admin
    And a user exists in the database
    And I visit that user's profile page
    When I click the edit link
    And I input valid email changes
    And I click the update user button
    Then I should see the user page
    And the email should be changed

  Scenario: Admin delete user
    Given an admin exists in the database
    And I am logged in as an admin
    And a user exists in the database
    When I visit that user's edit page
    And I click the delete link
    Then the user should be deleted

  Scenario: Admin edit recipe
    Given an admin exists in the database
    And I am logged in as an admin
    And a recipe exists in the database
    And I visit the recipe's edit page
    When I change the description
    And I click the next button
    And I click the done button
    Then I should see the description has changed

  Scenario: Admin delete recipe
    Given an admin exists in the database
    And I am logged in as an admin
    And a recipe exists in the database
    When I visit the index page
    And I click the delete link
    Then I should see the recipe removed