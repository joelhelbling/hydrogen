Given /^I add a deal "([^"]*)"$/ do |description|
  @transaction.add Deal.new(:description => description)
end

Given /^I add a deal 'one cent off for each item'$/ do
  deal = Deal.new(:description => '1 cent off each item')
  deal.logic do |items|
    items.select{|i| i.salable?}.inject(0) do |sum, item|
      sum += item.quantity * -0.01
    end
  end
  @transaction.add deal
end
