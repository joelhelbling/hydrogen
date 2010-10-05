Given /^I have a transaction$/ do
  @transaction = Transaction.new
end

Given /^I add "([^"]*)" at \$(\d+\.\d+)$/ do |description, amount|
  @transaction.add Item.new(:description => description, :amount => amount)
end

Given /^I add the following items:$/ do |table|
  table.hashes.each do |hash|
    price = hash['PRICE'].gsub(/\$/, "")
    Given "I add \"#{hash['DESCRIPTION']}\" at $#{price}"
  end
end

When /^I view the total$/ do
  @total_amount = @transaction.total
end

Then /^I see \$(\d+\.\d+)$/ do |total_amount|
  @total_amount.should == Float(total_amount)
end

Given /^I have sales tax at ([\d\.]+)%$/ do |tax_rate|
  @transaction.sales_tax = SalesTax.new(tax_rate.to_f/100)
end

Given /^I have a 'buy 2 get 1 free' deal for "([^\"]*)"$/ do |description|
  @transaction.discount = "33.33"
end

When /^I add another "([^\"]*)" at \$(\d+\.\d+)$/ do |description, amount|
  When "I add \"#{description}\" at $#{amount}"
end

Given /^I am a kid$/ do
  @transaction.customer_is_a_kid
end

When /^I count the number of line items$/ do
  @line_items_count = @transaction.line_items.size
end

Then /^I see "([^"]*)" line items$/ do |number_of_line_items|
  @line_items_count.should == number_of_line_items.to_i
end
