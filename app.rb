# Require relevant files to bootstrap the app.
require_relative 'app/models/meal'
require_relative 'app/repositories/meal_repository'
require_relative 'app/controllers/meals_controller'
require_relative 'app/models/customer'
require_relative 'app/repositories/customer_repository'
require_relative 'app/controllers/customers_controller'
require_relative 'app/models/employee'
require_relative 'app/repositories/employee_repository'
require_relative 'app/controllers/sessions_controller'
require_relative 'router'
# Test the program with:

csv_file = File.join(__dir__, './data/meals.csv')
customer_csv_file = File.join(__dir__, './data/customers.csv')
employee_csv_file = File.join(__dir__, './data/employees.csv')
meal = MealRepository.new(csv_file)
controller = MealsController.new(meal)
customer = CustomerRepository.new(customer_csv_file)
customers_controller = CustomersController.new(customer)
employee = EmployeeRepository.new(employee_csv_file)
employee_controller = SessionsController.new(employee)

router = Router.new(controller, customers_controller, employee_controller)

# Start the app
router.run
# ruby app.rb
