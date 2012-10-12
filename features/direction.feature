Feature: Directions manipulation

  @javascript
  Scenario: See a direction
    Given a recipe exists in the database
    And that recipe has a direction
    And I visit the recipe's show page
    Then I should see the direction

  @javascript
  Scenario: Destroy a direction
    Given a recipe exists in the database
    And that recipe has a direction
    And I visit the recipe's edit page
    And I click the next button
    When I click the delete button next to the direction
    Then I should see the direction has been removed

  @javascript
  Scenario: Ingredients cannot be used by multiple directions
    Given a recipe exists in the database
    And that recipe has a direction
    When I visit the recipe's edit page
    And I click the next button
    And I click the add new direction button
    Then I should not see ingredients already used

  @javascript
  Scenario: The product of directions should be available to use as ingredients
    Given a recipe exists in the database
    And that recipe has a direction
    When I visit the recipe's edit page
    And I click the next button
    And I click the add new direction button
    Then I should see the direction available for use as an ingredient

  @javascript
  Scenario: I should only see the direction titles
    Given a recipe exists in the database
    And that recipe has a direction
    When I visit the recipe's show page
    Then I should not see the direction text