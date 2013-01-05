@http://www.pivotaltracker.com/story/show/41122699
Feature: As a user, I can sign in using twitter

    @javascript
    Scenario: Sign in with valid twitter information
      Given a user exists in the database
      And I visit the sign in page
      When I choose to sign in with twitter
      And I enter valid twitter sign in information
      And click the login button
      Then I should not see the sign in page
      And I should see a success message
      And I should see I am signed in

    @javascript
    Scenario: Sign in with invalid twitter information
      Given a user exists in the database
      And I visit the sign in page
      When I choose to sign in with twitter
      And I enter invalid twitter sign in information
      And click the login button
      Then I should see I am not signed in
