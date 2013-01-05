@http://www.pivotaltracker.com/story/show/39548077
Feature: As a user, I can see the recipe creator's username even if the account associated is deleted.
  Scenario: Removed user's usernames remain
    Given a user exists in the database
    And a recipe exists in the database created by that user
    When I delete the user
    And I visit the recipe's show page
    Then I should see the deleted user's username
