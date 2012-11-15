Feature: User authentication

  Scenario: Try to sign up with invalid information
    Given I visit the sign up page
    When I enter invalid sign up information
    And click the create user button
    Then a user should not be created
    And I should see the sign up page
    And I should see an error message

  Scenario: Sign up with valid information
    Given I visit the sign up page
    When I enter valid sign up information
    And click the create user button
    Then a user should be created 
    And I should not see the sign up page    
    And I should see a success message

  Scenario: Sign in with invalid information
    Given a user exists in the database
    And I visit the sign in page
    When I enter invalid sign in information
    And click the sign in button
    Then I should see I am not signed in
    And I should see the sign in page    
    And I should see an invalid sign in message

  Scenario: Sign in with valid information
    Given a user exists in the database
    And I visit the sign in page
    When I enter valid sign in information
    And click the sign in button
    Then I should see I am signed in
    And I should not see the sign in page    
    And I should see a success message

  Scenario: Signing out
    Given a user exists in the database
    And I am logged in
    When I click the sign out link
    Then I should see I am not signed in
    And I should see a success message

  Scenario: User is redirected after login
    Given a user exists in the database
    And I visit that user's edit page
    And I am redirected to the login page
    When I enter valid sign in information
    And click the sign in button
    Then I should see my edit page