Feature: Here we explore deals, which are more complicated than 
a simple transaction-level discount.  Deals can be arbitrarily
complex; at the point that the transaction is totalled, they act
upon the entire set of items in the transaction.

  Background: stuff we always do
    Given I have a transaction

  Scenario: a simple non-acting deal
    Given I add "rod of lightening" at $1.00
    And I add "wheel 'o turnin'" at $1.00
    And I add a deal "nothing for nothing"
    When I view the total
    Then I see $2.00

  Scenario: one cent off for each item
    Given I add "rod of lightening" at $1.00
    And I add "wheel 'o turnin'" at $1.00
    And I add a deal 'one cent off for each item'
    When I view the total
    Then I see $1.98
