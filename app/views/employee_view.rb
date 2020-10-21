class EmployeeView
  def display(employees)
    employees.each_with_index do |employee, index|
      puts "#{index + 1}. #{employee.username}"
    end
  end

  def ask_user_for_index
    puts "Which employee number?"
    gets.chomp.to_i - 1
  end
end
