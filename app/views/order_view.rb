class OrderView
  def display(orders) # orders is an array of *instances* of `Order`
    orders.each_with_index do |order, index|
      puts "#{index + 1}. #{order.customer.name} wants a #{order.meal.name} - Delivery by: #{order.employee.username} #{ ']DELIVERED]' if order.delivered?}"
    end
  end

  def ask_user_for_index
    puts "Which order number?"
    gets.chomp.to_i - 1
  end
end
