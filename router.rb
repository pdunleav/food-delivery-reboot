class Router

  def initialize(meals_controller, customers_controller, sessions_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @running = true
  end

  def run
    employee = @sessions_controller.sign_in
    while @running
      if employee.manager?
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
      5. exit
    "
  end

  def print_delivery_person_actions
    puts "
      ------ what do you want to do?  -------
      1. list my orders (TODO)
      2. mark order complete (TODO)
      5. exit
    "
  end

  def handle_manager_action(choice)
    case choice
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add
    when 3 then @customers_controller.list
    when 4 then @customers_controller.add
    when 5 then stop
    else
      "Wrong input"
    end
  end

  def handle_delivery_person_action(choice)
    case choice
    when 1 then puts "TODO: show orders"
    when 2 then puts "TODO: mark order as complete"
    when 5 then stop
    else
      "Wrong input"
    end
  end

  def stop
    @running = false
  end
end
