Feature: A discount transaction

  Background: stuff we generally always do
    Given I have a transaction

  Scenario: a single item, no tax, with 10% discount
    Given I add "a gadget" at $4.00
    And I have a discount of "10%"
    When I view the total
    Then I see $3.60

  Scenario: Salesperson enters a negative discount
    Given I add "a gadget" at $4.00
    And I have a discount of "-10%"
    When I view the total
    Then I see $3.60

  Scenario: buy two, get one free, no tax
    Given I have a 'buy 2 get 1 free' deal for "whizbang"
    And I add "whizbang" at $10.00
    And I add another "whizbang" at $10.00
    And I add another "whizbang" at $10.00
    When I view the total
    Then I see $20.00

  Scenario:
    Given I am a kid
    And I add "a lollipop" at $1.00
    When I view the total
    Then I see $0.00
