require_relative '../repositories/meal_repository'
require_relative '../models/meal'
require_relative '../views/views'

class MealsController
  def initialize(meal_repo)
    @meal_repo = meal_repo
    @view = View.new
  end

  def add
    # 1. Get name of order from view
    name = @view.ask_user("What's the name of your order?")
    # 2. Get price of order from view
    price = @view.ask_user("What's the price of your order?").to_f
    # 3. Store the new order instance
    new_order = Meal.new({ name: name, price: price })
    # 4. Call the add order method from the repository
    @meal_repo.create(new_order)
  end

  def list
    # Displays each meal order in the repo
    @meal_repo.all.each { |meal| puts meal.name }
  end

  def display_list
    @view.display(@meal_repo.all)
  end

  def destroy
    # 1. Get index from user
    index = @view.ask_user("Please provide the index of the order you would like to delete").to_i
    # 2. Remove from repository
    @meal_repo.remove_meal(index - 1)
    # 3. Display modified list to console
  end
end
