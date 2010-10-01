class Deal
  attr_accessor :description, :amount

  def initialize(p={})
    @amount = p[:amount].to_f || 0.00
    @description = p[:description]
  end

  def logic(&block)
    @logic = block
  end

  def run(items)
    @amount = @logic.call(items) if @logic
  end

  def quantity
    1
  end

end
