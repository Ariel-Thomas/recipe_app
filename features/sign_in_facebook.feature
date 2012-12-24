@http://www.pivotaltracker.com/story/show/41122713
Feature: As a user, I can sign in using facebook
 
  @javascript
  Scenario: Sign in with valid facebook information
    Given a user exists in the database
    And I visit the sign in page
    When I choose to sign in with facebook 
    And I enter valid facebook sign in information
    And click the login button
    Then I should not see the sign in page  
    And I should see a success message
    And I should see I am signed in