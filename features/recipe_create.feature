Feature: Create a new recipe

  Scenario: Unsuccessful creation
    Given I visit the new recipe page
    When I submit invalid recipe information
    Then I should see an error message
    And I should return to the new page

  Scenario: Successful creation
    Given I visit the new recipe page
    When I submit valid recipe information
    Then I should see a new recipe created
    And I should see a success message
    And I should see the recipe's page