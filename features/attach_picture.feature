@http://www.pivotaltracker.com/story/show/39693617
Feature: As a user, I can attach a picture to a recipe and have it display in the show, index and profile views.

  Scenario: Attempt to attach an invalid picture
    Given a user exists in the database
    And a recipe exists in the database created by that user
    And I am logged in
    And I visit that recipe's edit page
    When I attach an invalid picture
    And I click the next button
    And I click the done button
    Then I should see the recipe's page
    And I should not see the picture

  Scenario: Attach valid picture
    Given a user exists in the database
    And a recipe exists in the database created by that user
    And I am logged in
    And I visit that recipe's edit page
    When I attach a valid picture
    And I click the next button
    And I click the done button
    Then I should see the recipe's page
    And I should see the picture

  Scenario: Attach valid picture, index thumbnail
    Given a user exists in the database
    And a recipe exists in the database created by that user
    And I am logged in
    And a picture is attached to that recipe
    When I visit the index page
    Then I should see the picture

  Scenario: Attach valid picture, profile thumbnail
    Given a user exists in the database
    And a recipe exists in the database created by that user
    And I am logged in
    And a picture is attached to that recipe
    When I visit my user page
    Then I should see the picture