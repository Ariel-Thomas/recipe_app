Feature: Create a new recipe

  @javascript  
  Scenario: Unsuccessful creation, Blank
    Given a user exists in the database
    And I am logged in
    When I visit the new recipe page
    And I click the next button
    Then I should return to the new page
 
  @javascript  
  Scenario: Successful creation
    Given a user exists in the database
    And I am logged in
    When I visit the new recipe page
    And I input valid recipe information
    And I click the next button
    And I click the add new direction button
    And I enter valid recipe directions
    And I click the add direction button
    And I click the done button
    Then I should see a new recipe created
    And I should see the recipe's page

  @javascript  
  Scenario: Successful creation, Poor ingredient formatting
    Given a user exists in the database
    And I am logged in
    When I visit the new recipe page
    And I input valid recipe information
    And I poorly format the ingredients
    And I click the next button
    And I click the done button
    Then I should see a new recipe created