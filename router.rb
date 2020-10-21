class Router

  def initialize(meals_controller, customers_controller, sessions_controller, orders_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @orders_controller = orders_controller
    @running = true
  end

  def run
    @employee = @sessions_controller.sign_in
    while @running
      if @employee.manager?
        print_manager_actions
        choice = gets.chomp.to_i
        handle_manager_action(choice)
      else
        print_delivery_person_actions
        choice = gets.chomp.to_i
        handle_delivery_person_action(choice)
      end
    end
  end

  def print_manager_actions
    puts "
      ------ what do you want to do?  -------
      1. list meals
      2. add meal
      3. list customers
      4. add customers
      5. list undelivered orders
      6. add order
      7. exit
    "
  end

  def print_delivery_person_actions
    puts "
      ------ what do you want to do?  -------
      1. list my undelivered orders
      2. mark order complete
      3. exit
    "
  end

  def handle_manager_action(choice)
    case choice
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add
    when 3 then @customers_controller.list
    when 4 then @customers_controller.add
    when 5 then @orders_controller.list_all_undelivered
    when 6 then @orders_controller.add
    when 7 then stop
    else
      "Wrong input"
    end
  end

  def handle_delivery_person_action(choice)
    case choice
    when 1 then @orders_controller.list_my_orders(@employee)
    when 2 then @orders_controller.mark_as_delivered(@employee)
    when 3 then stop
    else
      puts "Try again..."
    end
  end

  def stop
    @running = false
  end
end
