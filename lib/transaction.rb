class Transaction

  def initialize
    @discount_percentage = 0
    @tax_percentage = 0
    @customer_is_a_kid = false
  end

  def add(description, amount)
    @items ||= []
    @items << {:description => description, :amount => Float(amount)}
  end

  def total
    return 0.00 if @customer_is_a_kid
    pre_tax_total =
    @items.inject(0) do |sum, item|
      sum += item[:amount]
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

  private

  def round(number)
    (number * 100).round.to_f / 100
  end

end
