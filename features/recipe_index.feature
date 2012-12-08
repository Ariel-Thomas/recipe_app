Feature: Show an index of current recipes
  
  @javascript
  Scenario: See a list of recipes
    Given a recipe exists in the database
    And I visit the index page
    Then I should see that recipe

  @javascript
  Scenario: View a particular recipe
    Given a recipe exists in the database
    And I visit the index page
    When I click the recipe's link
    Then I should see the recipe's page

  @javascript
  Scenario: Users that do not own a recipe may not delete it
    Given a recipe exists in the database created by that user
    When I visit the index page
    Then I should not see a delete link

  @javascript
  Scenario: Delete a recipe
    Given a user exists in the database
    And a recipe exists in the database created by that user
    And I am logged in
    When I visit the index page
    And I click the delete link
    Then I should see the recipe removed
    And I should see a success message

  @javascript
  Scenario: Paginate results
    Given 11 recipes exist in the database
    And I visit the index page
    Then I should not see that last recipe

    