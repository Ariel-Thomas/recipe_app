Feature: Create a new recipe

  Scenario: Unsuccessful creation, Blank
    Given I visit the new recipe page
    When I submit the recipe
    Then I should see an error message
    And I should return to the new page

  Scenario: Successful creation
    Given I visit the new recipe page
    When I input valid recipe information
    And I submit the recipe
    Then I should see a new recipe created
    And I should see a success message
    And I should see the recipe's page

  Scenario: Successful creation, Poor ingredient formatting
    Given I visit the new recipe page
    When I input valid recipe information
    And I poorly format the ingredients
    And I submit the recipe
    Then I should see a new recipe created
    And I should see ingredients properly formatted
