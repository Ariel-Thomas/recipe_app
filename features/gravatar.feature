@http://www.pivotaltracker.com/story/show/39693763
Feature: As a user, I can attach a picture to my profile and have it display in my profile page.
  
  Scenario: User profile has avatar
    Given a user exists in the database
    When I visit that user's profile page
    Then I should see an avatar

  Scenario: User profile shows gravatar image 
    Given a user exists in the database
    And that user has an email linked to a valid gravatar account
    When I visit that user's profile page
    Then I should see that gravatar

  Scenario: User profile shows alternate image 
    Given a user exists in the database
    And that user has a link to an image
    When I visit that user's profile page
    Then I should see the image

  Scenario: Edit User with valid information
    Given a user exists in the database
    And I am logged in
    And I visit my user page
    When I click the edit link
    And I input valid avatar information
    And I click the update user button
    Then I should see the user page
    And I should see a success message
    And I should see the image