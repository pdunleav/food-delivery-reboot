require_relative '../views/order_view'
require_relative '../views/meal_view'
require_relative '../views/customer_view'
require_relative '../views/employee_view'

class OrdersController
  def initialize(order_repository, meal_repository, customer_repository, employee_repository)
    @order_repository = order_repository
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_view = OrderView.new
    @meal_view = MealView.new
    @customer_view = CustomerView.new
    @employee_view = EmployeeView.new
  end

  def list_all_undelivered
    # 1. find all undelivered orders
    undelivered_orders = @order_repository.all_undelivered_orders
    # 2. display them
    @order_view.display(undelivered_orders)
  end

  def add
    # get all meals (from the meal repository)
    all_meals = @meal_repository.all
    # display meals
    @meal_view.display(all_meals)
    # ask user for the index of the meal to order
    meal_index = @meal_view.ask_user_for_index

    meal_for_order = all_meals[meal_index]

    # get all customers (from the customer repository)
    all_customers = @customer_repository.all
    # display customers
    @customer_view.display(all_customers)
    # ask user for the index of the customer to order
    customer_index = @customer_view.ask_user_for_index

    customer_for_order = all_customers[customer_index]

    # get all delivery people (from the employee repository)
    all_delivery_people = @employee_repository.delivery_people
    # display employees
    @employee_view.display(all_delivery_people)
    # ask user for the index of the employee to order
    employee_index = @employee_view.ask_user_for_index

    employee_for_order = all_delivery_people[employee_index]

    new_order = Order.new(
      meal:     meal_for_order,
      customer: customer_for_order, # don't need to pass delivered because if we dont it defaults to `false`
      employee: employee_for_order
    )

    @order_repository.create(new_order)
  end

  def list_my_orders(user)
    orders = @order_repository.my_undelivered_orders(user)
    @order_view.display(orders)
  end

  def mark_as_delivered(user)
    list_my_orders(user)
    index = @order_view.ask_user_for_index
    my_orders = @order_repository.my_undelivered_orders(user)
    order = my_orders[index]
    @order_repository.mark_as_delivered(order)
  end
end
