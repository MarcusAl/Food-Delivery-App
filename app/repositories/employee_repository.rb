require 'csv'
require_relative '../models/employee'
require_relative '../views/views'
# This class handles the CRUD aspects for the customers
# It also updates the CSV file according to the current customer list
class EmployeeRepository
  def initialize(csv_filepath)
    @csv_filepath = csv_filepath
    @employees = []
    @view = View.new
    read_filepath
  end

  def find(id)
    # This method find the employee instance with an id that matches the condition
    @employees.find { |user| user.id.to_i == id.to_i }
  end

  def find_by_username(username)
    # This method find the employee instance with an username that matches the condition
    @employees.find { |user| user.username.to_s == username.to_s }
  end

  def all_riders
    # Returns the current employee array
    return @employees.select { |employee| employee.rider? }
  end

  def read_filepath
    # The hash formats the csv in a way which we can utilise in Ruby
    # Checks if the file exists before proceeding
    if File.exist?(@csv_filepath)
      # This function creates a new Employee object, with specific formatting,
      # -> It also updates the current employee array
      CSV.foreach(@csv_filepath, { headers: :first_row, header_converters: :symbol }) do |row|
        row[:id] = row[0].to_i
        row[:username] = row[1]
        row[:password] = row[2]
        @employees << Employee.new(row)
      end
    else
      p "Warning, no such file found at: #{@csv_filepath}"
    end
  end
end
