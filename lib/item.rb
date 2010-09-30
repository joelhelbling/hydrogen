class Item
  attr_accessor :id, :description, :amount, :quantity

  def initialize(p={})
    @quantity = p[:quantity] || 1
    @id = p[:id]
    @amount = p[:amount].to_f || 0.00
    @description = p[:description]
  end

  def amount=(amount)
    @amount = amount.to_f
  end

end
