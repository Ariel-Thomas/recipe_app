@http://www.pivotaltracker.com/story/show/39630395
Feature: As a user, I can favorite recipes I like and have them show in my profile

  Scenario: Favorites on profile page
    Given a user exists in the database
    And a recipe exists in the database
    And that user has favorited that recipe
    When I visit that user's profile page
    Then I should see that recipe

  Scenario: Unable to favorite while not logged in
    Given a recipe exists in the database
    When I visit that recipe's show page
    Then I cannot see the favorite button
    And I cannot see the unfavorite button

  Scenario: Favoriting a recipe
    Given a user exists in the database
    And I am logged in
    And a recipe exists in the database
    When I visit that recipe's show page
    And I click the favorite button
    Then I can see the unfavorite button
    And I cannot see the favorite button
    And I should have that recipe favorited

  Scenario: Unfavoriting a recipe
    Given a user exists in the database
    And a recipe exists in the database
    And that user has favorited that recipe
    And I am logged in
    And I should have that recipe favorited
    When I visit that recipe's show page
    And I click the unfavorite button
    Then I can see the favorite button
    And I cannot see the unfavorite button
    And I should no longer have that recipe favorited