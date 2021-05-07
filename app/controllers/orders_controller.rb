require_relative '../repositories/customer_repository'
require_relative '../repositories/employee_repository'
require_relative '../repositories/meal_repository'
require_relative '../repositories/order_repository'
require_relative '../views/views'
require_relative '../models/order'
class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository
    @view = View.new
  end

  def mark_as_delivered(id)
    @order_repository.find(id).deliver!
    @order_repository.save_csv
  end

  def list_my_orders(employee)
    undelivered_arr = @order_repository.undelivered_orders
    undelivered_arr.select { |order| order.employee.username == employee }
    # puts undelivered_arr.find { |order| order.employee.to_s == employee }
  end

  def list_undelivered_orders
    orders = @order_repository.undelivered_orders
    @view.list_orders(orders)
  end

  def add
    order = {}
    # 1. Get meal index from view
    meal_index = @view.ask_user("What's the meal index?")
    order[:meal] = @meal_repository.find(meal_index.to_i)
    # 2. Get customer index from view
    customer_index = @view.ask_user("What's the customers index?")
    order[:customer] = @customer_repository.find(customer_index.to_i)
    # 3. Store the new customer instance
    employee_index = @view.ask_user("What's the employee index?")
    order[:employee] = @employee_repository.find(employee_index.to_i + 1)
    # 4. Call the create method from the repository
    new_order = Order.new(order)
    @order_repository.create(new_order)
  end
end