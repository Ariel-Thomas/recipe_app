Feature: Create a new recipe

  @javascript  
  Scenario: Unsuccessful creation, Blank
    Given I visit the new recipe page
    When I click the next button
    Then I should return to the new page

  Scenario: Successful creation
    Given I visit the new recipe page
    When I input valid recipe information
    And I click the next button
    And I click the add new direction button
    And I enter valid recipe directions
    And I click the add direction button
    And I click the done button
    Then I should see a new recipe created
    And I should see a success message
    And I should see the recipe's page

  Scenario: Successful creation, Poor ingredient formatting
    Given I visit the new recipe page
    When I input valid recipe information
    And I poorly format the ingredients
    And I click the next button
    Then I should see a new recipe created