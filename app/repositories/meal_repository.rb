require 'csv'
require_relative '../models/meal'
require_relative '../views/views'

# This class handles the CRUD aspects for the meals
# It also updates the CSV file according to the current meals list
class MealRepository
  def initialize(csv_filepath)
    @csv_filepath = csv_filepath
    @meals = []
    @view = View.new
    read_csv
  end

  def remove_meal(index)
    # Prompt user if the index is not there
    if @meals[index]
      @meals.delete_at(index)
      save_csv
      # Otherwise delete the order at the specified index
    else
      @view.user_error
    end
  end

  def all
    # Returns the current meals array
    return @meals
  end

  def create(meal)
    # Checks if the meal is the first in array
    # If condition is true, the id is set at 1, otherwise its set to 1 more than the last
    if @meals.empty?
      meal.id = 1
    else
      meal.id = @meals.last.id + 1
    end
    # Adds a new meal to the meals array
    @meals << meal
    # Saves the current meals array to the csv
    save_csv
  end

  def find(id)
    # This method find the meal instance with an id that matches the condition
    @meals.find { |meal| meal.id.to_i == id.to_i }
  end

  def read_csv
    # The hash formats the csv in a way which we can utilise in Ruby
    # Checks if the file exists before proceeding
    if File.exist?(@csv_filepath)
      # This function creates a new Meal object, with specific formatting,
      # -> It also updates the current meals array
      CSV.foreach(@csv_filepath, { headers: :first_row, header_converters: :symbol }) do |row|
        row[:id] = row[0].to_i
        row[:name] = row[1]
        row[:price] = row[2].to_i
        # new_customer = Meal.new(row)
        @meals << Meal.new(row)
      end
    else
      @view.user_error
    end
  end

  def save_csv
    # This method opens the CSV and replaces the data with the current
    # -> instances/values in the meals list array
    CSV.open(@csv_filepath, 'wb') do |csv|
      csv << ['id', 'name', 'price']
      @meals.each do |arr|
        csv << [arr.id, arr.name, arr.price]
      end
    end
  end
end
