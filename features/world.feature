Feature: Destroy world
  @javascript
  Scenario: God aims to destroy the world
    Given I am "god@heaven.com"
    When I go on the world page
    And I click on the button "Apocalypse"
    Then I see "Apocalypse now"

  Scenario: user other than "god@heaven.com" has no button "Apocalypse"
    Given I am "adam@heaven.com"
    When I go on the world page
    Then I can not see any button "Apocalypse now"

  Scenario: user not logged" has no button "Apocalypse"
    When I go on the world page
    Then I can not see any button "Apocalypse now"
