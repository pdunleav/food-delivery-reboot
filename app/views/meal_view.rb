class MealView
  def ask_user_for(stuff)
    puts "Please give me a #{stuff}"
    gets.chomp
  end

  def display(meals)
    meals.each_with_index do |meal, index|
      puts "#{index + 1}. #{meal.name} - £#{meal.price}"
    end
  end

  def ask_user_for_index
    puts "Which meal number?"
    gets.chomp.to_i - 1
  end
end
