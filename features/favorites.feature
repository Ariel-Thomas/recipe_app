@http://www.pivotaltracker.com/story/show/39630395
Feature: As a user, I can favorite recipes I like and have them show in my profile

  Scenario: Favorites on profile page
    Given a user exists in the database
    And a recipe exists in the database
    And that user has favorited the recipe
    When I visit that user's profile page
    Then I should see the recipe

  Scenario: Unable to favorite while not logged in
    Given a recipe exists in the database
    When I visit the recipe's show page
    Then I cannot see the favorite button
    And I cannot see the unfavorite button

  Scenario: Favoriting a recipe
    Given a user exists in the database
    And I am logged in
    And a recipe exists in the database
    When I visit the recipe's show page
    And I click the favorite button
    Then I can see the unfavorite button
    And I cannot see the favorite button
    And I should have the recipe favorited

  Scenario: Unfavoriting a recipe
    Given a user exists in the database
    And a recipe exists in the database
    And that user has favorited the recipe
    And I am logged in
    And I should have the recipe favorited
    When I visit the recipe's show page
    And I click the unfavorite button
    Then I can see the favorite button
    And I cannot see the unfavorite button
    And I should no longer have the recipe favorited