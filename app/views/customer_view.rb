class CustomerView
  def display(customers)
    customers.each_with_index do |customer, index|
      puts "#{index + 1}. #{customer.name} : #{customer.address}"
    end
  end

  def ask_user_for(stuff)
    puts "#{stuff.capitalize}?"
    print "> "
    return gets.chomp
  end

  def ask_user_for_index
    puts "Which customer number?"
    gets.chomp.to_i - 1
  end
end
