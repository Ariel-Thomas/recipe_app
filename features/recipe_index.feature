Feature: Show an index of current recipes
  
  @javascript
  Scenario: See a list of recipes
    Given a recipe exists in the database
    And I visit the index page
    Then I should see the recipe

  @javascript
  Scenario: View a particular recipe
    Given a recipe exists in the database
    And I visit the index page
    When I click the recipe's link
    Then I should see the recipe's page

  @javascript
  Scenario: Delete a recipe
    Given a recipe exists in the database
    And I visit the index page
    When I click the delete link
    Then I should see the recipe removed
    And I should see a success message

  @javascript
  Scenario: Search for a recipe
    Given a recipe exists in the database
    And I visit the index page
    When I enter the recipe name in the search
    And I click the search button
    Then I should see the recipe

  @javascript
  Scenario: Paginate results
    Given 11 recipes exist in the database
    And I visit the index page
    Then I should not see the last recipe