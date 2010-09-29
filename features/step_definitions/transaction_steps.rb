Given /^I have a transaction$/ do
  @transaction = Transaction.new
end

Given /^I add "([^"]*)" at \$(\d+\.\d+)$/ do |description, amount|
  @transaction.add(description, amount)
end

Given /^I add the following items:$/ do |table|
  table.hashes.each do |hash|
    amount = hash['AMOUNT'].gsub(/\$/, "")
    Given "I add \"#{hash['DESCRIPTION']}\" at $#{amount}"
  end
end

When /^I view the total$/ do
  @total_amount = @transaction.total
end

Then /^I see \$(\d+\.\d+)$/ do |total_amount|
  @total_amount.should == Float(total_amount)
end

Given /^I have sales tax at ([\d\.]+)%$/ do |tax_rate|
  @transaction.tax_rate = tax_rate
end
