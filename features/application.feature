Feature: Basic layout should allow for easy navigation

  @search
  Scenario: Visit the recipe index page from any page
    Given I visit any page
    When I click the recipes link
    Then I should see the recipes index

  @search
  Scenario: Visit the new recipe page from any page
    Given I visit any page
    When I click the new recipe link
    Then I should see the new recipe page

