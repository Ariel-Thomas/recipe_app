Feature: Directions manipulation

  @javascript
  Scenario: See a direction
    Given a recipe exists in the database
    And that recipe has a direction
    And I visit that recipe's show page
    Then I should see that direction

  @javascript
  Scenario: Destroy a direction
    Given a user exists in the database
    And a recipe exists in the database created by that user
    And I am logged in
    And that recipe has a direction
    And I visit that recipe's edit page
    And I click the next button
    When I click the delete button next to the direction
    Then I should see the direction has been removed

  @javascript
  Scenario: Trying to create an invalid direction
    Given a user exists in the database
    And a recipe exists in the database created by that user
    And I am logged in
    When I visit that recipe's edit page
    And I click the next button
    And I click the add new direction button
    And I input invalid direction information
    And I click the add direction button
    Then I should still see the direction form
    And I should still see my previous input
    And I should see an error message

  @javascript
  Scenario: Create a direction
    Given a user exists in the database
    And a recipe exists in the database created by that user
    And I am logged in
    When I visit that recipe's edit page
    And I click the next button
    And I click the add new direction button
    And I enter valid recipe directions
    And I click the add direction button
    Then I should not still see the direction form
    And I should see the new direction
    And I should see a success message

  @javascript
  Scenario: Ingredients cannot be used by multiple directions
    Given a user exists in the database
    And a recipe exists in the database created by that user
    And I am logged in
    And that recipe has a direction
    When I visit that recipe's edit page
    And I click the next button
    And I click the add new direction button
    Then I should not see ingredients already used by that recipe

  @javascript
  Scenario: The product of directions should be available to use as ingredients
    Given a user exists in the database
    And a recipe exists in the database created by that user
    And I am logged in
    And that recipe has a direction
    When I visit that recipe's edit page
    And I click the next button
    And I click the add new direction button
    Then I should see that direction available for use as an ingredient