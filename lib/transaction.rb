class Transaction

  def initialize
    @discount_percentage = 0
    @tax_percentage = 0
    @customer_is_a_kid = false
  end

  def add(line_item)
    @items ||= []
    @items.each do |item|
      if items_identical?(item, line_item)
        item.quantity += line_item.quantity
        line_item = nil
      end
    end
    @items << line_item if line_item
  end

  def total
    return 0.00 if @customer_is_a_kid
    @items.each do |item|
      item.run(@items) if item.respond_to? :run
    end
    pre_tax_total =
    @items.inject(0) do |sum, item|
      sum += (item.amount * item.quantity) || 0.00
    end
    total = pre_tax_total + (pre_tax_total * @tax_percentage)

    total = total - (total * @discount_percentage)
    round total
  end

  def tax_rate=(rate)
    @tax_percentage = Float(rate) / 100
  end

  def discount=(percentage)
    @discount_percentage = Float(percentage).abs / 100
  end

  def customer_is_a_kid
    @customer_is_a_kid = true
  end

  def line_items
    @items + [{:description => "sales tax at #{@tax_percentage * 100}%"}]
  end

  private

  def items_identical?(item1, item2)
    item1.description.eql?(item2.description) &&
      item1.id == item2.id &&
      item1.amount == item2.amount
  end

  def round(number)
    (number * 100).round.to_f / 100
  end

end
