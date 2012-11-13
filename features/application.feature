Feature: Basic layout should allow for easy navigation

  Scenario: Visit the recipe index page from any page
    Given I visit any page
    When I click the recipes link
    Then I should see the recipes index

  Scenario: Visit the new recipe page from any page
    Given I visit any page
    When I click the new recipe link
    Then I should see the new recipe page

  Scenario: Visit the sign up page from any page
    Given I visit any page
    When I click the sign up link
    Then I should see the sign up page