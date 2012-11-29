Feature: Show an individual recipe
  
  @javascript
  Scenario: See recipe information
    Given a recipe exists in the database
    When I visit that recipe's show page
    Then I should see that recipe's information
  
  @javascript
  Scenario: Users that do not own a recipe may not edit it
    Given a recipe exists in the database
    When I visit that recipe's show page
    Then I should not see an edit link

  @javascript
  Scenario: Visit the recipe's edit page
    Given a user exists in the database
    And a recipe exists in the database created by that user
    And I am logged in
    When I visit that recipe's show page
    And I click the edit link
    Then I should see the recipe's edit page

  @javascript
  Scenario: Users that do not own a recipe may not delete it
    Given a recipe exists in the database created by that user
    When I visit that recipe's show page
    Then I should not see a delete link

  @javascript
  Scenario: Delete a recipe
    Given a user exists in the database
    And a recipe exists in the database created by that user
    And I am logged in
    When I visit that recipe's show page
    And I click the delete link
    Then I should see the recipe removed
    And I should see a success message

  @javascript
  Scenario: I should only see the direction titles
    Given a recipe exists in the database
    And that recipe has a direction
    When I visit that recipe's show page
    Then I should not see that direction's text

  @javascript
  Scenario: Clicking on a direction title should show the direction text
    Given a recipe exists in the database
    And that recipe has a direction
    When I visit that recipe's show page
    And I click the direction title
    Then I should see that direction's text