Feature: Edit a recipe

  Scenario: Edit content
    Given a recipe exists in the database
    And I visit the recipe's edit page
    When I change the description
    And I click the edit button
    Then I should see the description has changed
    And I should see a success message