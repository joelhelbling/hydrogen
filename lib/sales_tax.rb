class SalesTax
  attr_accessor :tax_rate
  attr_reader :amount

  def initialize(tax_rate=0.00)
    if tax_rate.is_a?(String) && tax_rate.match(/\%/)
      tax_rate = tax_rate.gsub(/\%/, '').to_f / 100
    end
    @tax_rate = tax_rate
    @logic = lambda do |items|

      items.inject(0) do |sum, item|
        sum += item.amount * @tax_rate
      end
    end
  end

  def calculate(items)
    @amount = @logic.call(items)
  end

  def logic(&block)
    @logic = block
  end

end