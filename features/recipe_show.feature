Feature: Show an individual recipe
  
  @javascript
  Scenario: See recipe information
    Given a recipe exists in the database
    When I visit the recipe's show page
    Then I should see the recipe's information

  @javascript
  Scenario: Visit the recipe's edit page
    Given a recipe exists in the database
    And I visit the recipe's show page
    When I click the edit link
    Then I should see the recipe's edit page

  @javascript
  Scenario: Delete the recipe
    Given a recipe exists in the database
    And I visit the recipe's show page
    When I click the delete link
    Then I should see the recipe removed
    And I should see a success message