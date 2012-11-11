Feature: Edit a recipe

  @javascript
  Scenario: Edit content
    Given a recipe exists in the database
    And I visit the recipe's edit page
    When I change the description
    And I click the next button
    And I click the done button
    Then I should see the description has changed