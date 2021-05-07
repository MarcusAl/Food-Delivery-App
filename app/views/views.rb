require_relative '../repositories/meal_repository'
require_relative '../models/meal'
require_relative '../controllers/meals_controller'

class View
  def display(list)
    # Display the current meals/orders to user with formatting
    puts "-- Here are all your current orders --"
    list.each_with_index do |order, index|
      puts '*' * 50
      puts "#{index + 1}.#{order.name} "
      puts "ID: #{order.id}"
      puts "Price: $#{order.price}"
      puts '*' * 50
    end
  end

  def display_customers(list)
    # Display the current customers to user with formatting
    puts "-- Here are all your current customers --"
    list.each_with_index do |customer, index|
      puts '*' * 50
      puts "#{index + 1}.#{customer.name} "
      puts "ID: #{customer.id}"
      puts "Address: #{customer.address}"
      puts '*' * 50
    end
  end

  def list_orders(orders)
    orders.each do |order|
      puts "#{order.id} - customer: #{order.customer.name} - meal: #{order.meal.name} - address: #{order.customer.address}"
    end
  end

  def ask_user(message)
    puts message
    print "> "
    return gets.chomp
  end

  def user_error
    puts "Error. The input you provided is incorrect"
  end
end
