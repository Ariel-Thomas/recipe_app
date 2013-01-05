@http://www.pivotaltracker.com/story/show/39637311
Feature: As a user, I can write about myself on my profile page
  Scenario: Profile page shows about me
    Given a user exists in the database
    And that user has a valid about me
    When I visit that user's profile page
    Then I should see the about me text

  Scenario: Edit User's about me
    Given a user exists in the database
    And I am logged in
    And I visit my user page
    When I click the edit link
    And input valid about me text
    And I click the update user button
    Then I should see the user page
    And I should see my new about me text
