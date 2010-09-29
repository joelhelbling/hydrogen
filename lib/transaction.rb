class Transaction

  def add(description, amount)
    @items ||= []
    @items << {:description => description, :amount => Float(amount)}
  end

  def total
    pre_tax_total =
    @items.inject(0) do |sum, item|
      sum += item[:amount]
    end
    total = pre_tax_total + (pre_tax_total * (@tax_percentage || 0))
    round total
  end

  def tax_rate=(rate)
    @tax_percentage = Float(rate) / 100
  end

  private

  def round(number)
    (number * 100).round.to_f / 100
  end

end
