Given /^I add a deal "([^"]*)"$/ do |description|
  @transaction.add Deal.new(:description => description)
end

Given /^I add a deal 'one cent off for each item'$/ do
  deal = Deal.new(:description => '1 cent off each item')
  deal.logic do |items|
    amount = 
    items.inject(0) do |sum, item|
      qty = item.respond_to?(:quantity) && item.quantity ? item.quantity : 0
      sum += qty * -0.01
    end
    amount
  end
  @transaction.add deal
end
