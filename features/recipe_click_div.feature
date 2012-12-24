@http://www.pivotaltracker.com/story/show/39695063
Feature: As a user, in the recipe list, I can click on the recipe (not just the title) to take me to the recipe
  Scenario: Clicking on recipe div
    Given a recipe exists in the database
    And I visit the index page
    When I click the recipe's div
    Then I should see the recipe's page
