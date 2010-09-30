Feature: A basic transaction

  Background: stuff we generally always do
    Given I have a transaction
  
  Scenario: Single item, no tax
    Given I add "a gizmo" at $2.99
    When I view the total
    Then I see $2.99

  Scenario: Single item, 10% tax
    Given I add "a whizbang" at $3.00
    And I have sales tax at 10%
    When I view the total
    Then I see $3.30

  Scenario: Multiple items, 10% tax
    Given I add "a dobamathingie" at $2.99
    And I add "a whatchamacallit" at $1.99
    And I have sales tax at 10%
    When I view the total
    Then I see $5.48

  Scenario: Lots of items, 7.5% tax
    Given I add the following items:
      | DESCRIPTION            | AMOUNT  |
      | white flange           | $109.95 |
      | hexigonal bushing      |   $0.29 |
      | flexible washer washer |  $24.99 |
      | fridge magnet          |   $1.09 |
      | peanut cracker         |   $4.95 |
    And I have sales tax at 7.5%
    When I view the total
    Then I see $151.87
