require 'csv'
require_relative '../models/order'
require_relative '../views/views'
require_relative 'customer_repository'
require_relative 'meal_repository'
require_relative 'employee_repository'
# This class handles the CRUD aspects for the orders
# It also updates the CSV file according to the current order list
class OrderRepository
  attr_reader :meal, :customer, :employee

  def initialize(csv_filepath, meal_repository, customer_repository, employee_repository)
    @csv_filepath = csv_filepath
    @orders = []
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @meal_repository = meal_repository
    @num = 1
    read_filepath
  end

  def undelivered_orders
    @orders.reject { |order| order.delivered? }
  end

  def create(order)
    # Checks if the order is the first in array
    # If condition is true, the id is set at 1, otherwise its set to 1 more than the last
    if @orders.empty?
      order.id = 1
    else
      order.id = @orders.last.id.to_i + 1
    end
    # Adds a new order to the orders array
    @orders << order
    # # Saves the current order array to the csv
    save_csv
  end

  def find(id)
    # This method find the order instance with an id that matches the condition
    @orders.find { |order| order.id == id }
  end

  def read_filepath
    # The hash formats the csv in a way which we can utilise in Ruby
    # Checks if the file exists before proceeding
    if File.exist?(@csv_filepath)
      # This function creates a new Employee object, with specific formatting,
      # -> It also updates the current employee array
      CSV.foreach(@csv_filepath, { headers: :first_row, header_converters: :symbol }) do |row|
        row[:id] = row[:id].to_i
        row[:delivered] = row[:delivered] == 'true'
        row[:meal] = @meal_repository.find(row[:meal_id].to_i)
        row[:customer] = @customer_repository.find(row[:customer_id].to_i)
        row[:employee] = @employee_repository.find(row[:employee_id].to_i)
        order = Order.new(row)
        @orders << order
      end
      @num += 1
    else
      p "Warning, no such file found at: #{@csv_filepath}"
    end
  end

  def save_csv
    # This method opens the CSV and replaces the data with the current
    # -> instances/values in the meals list array
    CSV.open(@csv_filepath, 'wb') do |csv|
      csv << ['id', 'delivered', 'meal_id', 'customer_id', 'employee_id']
      @orders.each do |element|
        csv << [element.id, element.delivered, element.meal.id, element.customer.id, element.employee.id]
      end
    end
  end
end