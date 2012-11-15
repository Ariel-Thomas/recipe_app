Feature: Edit a recipe

  @javascript
  Scenario: Edit content
    Given a user exists in the database
    And a recipe exists in the database created by that user
    And I am logged in
    And I visit the recipe's edit page
    When I change the description
    And I click the next button
    And I click the done button
    Then I should see the description has changed
    And I should see the recipe's page
