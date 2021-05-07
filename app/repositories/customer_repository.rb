require 'csv'
require_relative '../models/customer'
require_relative '../views/views'
class CustomerRepository
  # This class handles the CRUD aspects for the customers
  # It also updates the CSV file according to the current customer list
  def initialize(csv_filepath)
    @csv_filepath = csv_filepath
    @customers = []
    @view = View.new
    read_filepath
  end

  def remove_customer(index)
    # Prompt user if the index is not there
    if @customers[index]
      @customers.delete_at(index)
      save_filepath
      # Otherwise delete the customer at the specified index
    else
      @view.user_error
    end
  end

  def find(id)
    # This method find the meal instance with an id that matches the condition
    @customers.find { |user| user.id.to_i == id }
  end

  def all
    # Returns the current meals array
    return @customers
  end

  def create(customer)
    # Checks if the customer is the first in array
    # If condition is true, the id is set at 1, otherwise its set to 1 more than the last
    if @customers.empty?
      customer.id = 1
    else
      customer.id = @customers.last.id + 1
    end
    # Adds a new customer to the customer array
    @customers << customer
    # Saves the current customer array to the csv
    save_filepath
  end

  def read_filepath
    # The hash formats the csv in a way which we can utilise in Ruby
    # Checks if the file exists before proceeding
    if File.exist?(@csv_filepath)
      # This function creates a new Customer object, with specific formatting,
      # -> It also updates the current customer array
      CSV.foreach(@csv_filepath, { headers: :first_row, header_converters: :symbol }) do |row|
        row[:id] = row[0].to_i
        row[:name] = row[1]
        row[:address] = row[2]
        # new_customer = Meal.new(row)
        @customers << Customer.new(row)
      end
    else
      p "Warning, no such file found at: #{@csv_filepath}"
    end
  end

  def save_filepath
    # This method opens the CSV and replaces the data with the current
    # -> instances/values in the meals list array
    CSV.open(@csv_filepath, 'wb') do |csv|
      csv << ['id', 'name', 'address']
      @customers.each do |arr|
        csv << [arr.id, arr.name, arr.address]
      end
    end
  end
end

# new_customer = CustomerRepository.new('./data/customers.csv')
# new_customer.read_filepath
# p new_customer.customers
