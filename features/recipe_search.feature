Feature: Searching through recipes

  @javascript
  Scenario: Search for a recipe by name
    Given a recipe exists in the database
    And a different recipe exists in the database
    And I visit the index page
    When I enter that recipe's name in the search
    And I click the search button
    Then I should see that recipe
    And I should not see that other recipe

  @javascript
  Scenario: Search for a recipe by description
    Given a recipe exists in the database
    And a different recipe exists in the database
    And I visit the index page
    When I enter that recipe's description in the search
    And I click the search button
    Then I should see that recipe
    And I should not see that other recipe

  @javascript
  Scenario: Search for a recipe by author
    Given a user exists in the database
    And a recipe exists in the database created by that user
    And a different recipe exists in the database
    And I visit the index page
    When I enter that recipe's author in the search
    And I click the search button
    Then I should see that recipe
    And I should not see that other recipe

  @javascript
  Scenario: Search for a recipe by ingredient name
    Given a recipe exists in the database
    And a different recipe exists in the database
    And I visit the index page
    When I enter that recipe's first ingredient in the search
    And I click the search button
    Then I should see that recipe
    And I should not see that other recipe