Feature: Create a new recipe

  Scenario: Unsuccessful creation
    Given a user visits the new recipe page
    When he submits invalid recipe information
    Then he should see an error message

  Scenario: Successful creation
    Given a user visits the new recipe page
    When he submits valid recipe information
    Then he should create a new recipe
    And he should see a success message