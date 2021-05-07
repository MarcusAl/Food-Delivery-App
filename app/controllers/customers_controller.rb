require_relative '../repositories/customer_repository'
require_relative '../views/views'
class CustomersController
  # This class handles the management of adding and listing customer data
  # It is initialized with the customer repo class
  def initialize(customer_repo)
    @customer_repo = customer_repo
    @view = View.new
  end

  def add
    # 1. Get name of customer from view
    name = @view.ask_user("What's the customers name?")
    # 2. Get address of customer from view
    address = @view.ask_user("What's the customers address?")
    # 3. Store the new customer instance
    new_customer = Customer.new({ name: name, address: address })
    # 4. Call the create method from the repository
    @customer_repo.create(new_customer)
  end

  def list
    # Displays each customer information in the repo
    @customer_repo.all.each { |user| puts user.name }
  end

  def display_list
    @view.display_customers(@customer_repo.all)
  end

  def destroy
    # 1. Get index from user
    index = @view.ask_user("Please provide the index of the customer you would like to delete").to_i
    # 2. Remove from repository
    @customer_repo.remove_customer(index - 1)
    # 3. Display modified list to console
  end
end
