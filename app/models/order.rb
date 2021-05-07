class Order
  attr_reader :meal, :customer, :employee
  attr_accessor :id, :delivered

  def initialize(attr = {})
    @id = attr[:id] || 0
    @meal = attr[:meal] || 'No Meal'
    @customer = attr[:customer] || 'No Customer'
    @employee = attr[:employee] || 'No Employee'
    @delivered = attr[:delivered] || false
  end

  def delivered?
    @delivered == true
  end

  def deliver!
    @delivered = true
  end
end
