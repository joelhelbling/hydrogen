class Transaction
  attr_accessor :sales_tax
  attr_reader :line_items

  def initialize
    @line_items = []
  end

  def add(item)
    @line_items.each do |line_item|
      if items_identical?(item, line_item)
        line_item.quantity += item.quantity
        item = nil
      end
    end
    @line_items << item unless item.nil?
  end

  def total
    calculate_deals
    @sales_tax.calculate(@line_items) if @sales_tax
    sales_tax = @sales_tax && @sales_tax.amount || 0.00
    round pre_tax_total + sales_tax
  end

  private

  def items_identical?(item1, item2)
    item1.description.eql?(item2.description) &&
      item1.id == item2.id &&
      item1.amount == item2.amount
  end

  def calculate_deals
    @line_items.reject{|i| i.salable? }.each do |deal|
      deal.calculate(@line_items)
    end
  end

  def pre_tax_total
    @line_items.select{|i| i.amount }.inject(0) do |sum, item|
      quantity = item.salable? ? item.quantity : 1
      sum += item.amount * quantity
    end
  end

  def salable_items
    @line_items.select do |item|
      item.salable?
    end
  end

  def round(number)
    (number * 100).round.to_f / 100
  end

end
