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
      | DESCRIPTION            | PRICE   |
      | white flange           | $109.95 |
      | hexagonal bushing      |   $0.29 |
      | flexible washer washer |  $24.99 |
      | fridge magnet          |   $1.09 |
      | peanut cracker         |   $4.95 |
    And I have sales tax at 7.5%
    When I view the total
    Then I see $151.87

  Scenario: shows a list of items
    Given I add "fire cracker" at $3.00
    And I add "whistle" at $2.50
    And I have sales tax at 2%
    When I count the number of line items
    Then I see "2" line items

  Scenario: duplicate items should be collapsed into a single line item
    Given I add "inkpot" at $2.00
    And I add another "inkpot" at $2.00
    When I count the number of line items
    Then I see "1" line items

  Scenario: duplicate items should increment the quantity for their line item
    Given I add "lone sock" at $2.00
    And I add another "lone sock" at $2.00
    And I add another "lone sock" at $2.00
    When I view the total
    And I count the number of line items
    Then I see $6.00
    And I see "1" line items