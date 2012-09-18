Feature: Show an index of current recipes
  
  Scenario: See a list of recipes
    Given a recipe exists in the database
    And I visit the index page
    Then I should see the recipe

  Scenario: View a particular recipe
    Given a recipe exists in the database
    And I visit the index page
    When I click the recipe's link
    Then I should see the recipe's page

  Scenario: Delete a recipe
    Given a recipe exists in the database
    And I visit the index page
    When I click the delete link
    Then I should see the recipe removed
    And I should see a success message