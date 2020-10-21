class Order
  attr_accessor :id
  attr_reader :customer, :meal, :employee
  # STATE: @id, @customer, @meal, @employee, @delivered
  def initialize(attributes = {})
    @id = attributes[:id]
    @customer = attributes[:customer] # Instance of the `Customer` class
    @meal = attributes[:meal]         # Instance of the `Meal` class
    @employee = attributes[:employee] # Instance of the `Employee` class
    @delivered = attributes[:delivered] || false
  end

  def delivered?
    @delivered
  end

  def deliver!
    @delivered = true
  end
end
