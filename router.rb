# TODO: implement the router of your app.
class Router
  def initialize(controller, customers_controller, sessions_controller)
    @controller = controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @running = true
    @user = nil
  end

  # rubocop:disable Metrics/MethodLength
  def display_tasks
    puts "------------------------------"
    puts "------------ MENU ------------"
    puts "------------------------------"
    puts "What do you want to do"
    puts "1 - List all orders"
    puts "2 - Add an new order"
    puts "3 - Remove a order"
    puts "4 - List all customers"
    puts "5 - Add a new customer"
    puts "6 - Remove a customer"
    puts "7 - Logout"
    puts "8 - Quit"
    print "> "
  end
  # rubocop:enable Metrics/MethodLength

  def display_delivery_tasks
    puts "------------------------------"
    puts "------------ MENU ------------"
    puts "------------------------------"
    puts "What do you want to do"
    puts "1 - See all my undelivered orders"
    puts "2 - mark an order as delivered"
    puts "3 - logout"
    puts "4 - Quit"
    print "> "
  end

  def route_delivery_action(choice)
    case choice
    when 1 then puts "here are your orders"
    when 2 then puts "order delivered"
    when 3 then @user = nil
    when 4
      @running = false
      @user = nil
    else
      puts "try again"
    end
  end

  # This method runs the program, and handles the display
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Style/WhileUntilDo
  def run
    while @running do
      @user = @sessions_controller.login
      while @user do
        if @user.rider?
          display_delivery_tasks
          input = gets.chomp.to_i
          route_delivery_action(input)
        else
          display_tasks
          action = gets.chomp.to_i
          route_action(action)
        end
      end
    end
  end
  # rubocop:enable Style/WhileUntilDo
  # rubocop:enable Metrics/MethodLength

  def enter_num
    puts
    puts "Please press a number from 1 to 7"
    puts
  end

  private

  # This method will call on the respective controller class
  # -> based on the user selection/input, or exit the program

  # rubocop:disable Metrics/PerceivedComplexity
  def route_action(action)
    @controller.display_list if action == 1
    @controller.add if action == 2
    @controller.destroy if action == 3
    @customers_controller.display_list if action == 4
    @customers_controller.add if action == 5
    @customers_controller.destroy if action == 6
    @user = nil if action == 7
    action ==  8 ? stop : enter_num
  end
  # rubocop:enable Metrics/PerceivedComplexity

  def stop
    @running = false
    @user = nil
  end
end
