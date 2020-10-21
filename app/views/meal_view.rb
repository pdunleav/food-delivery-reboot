class MealView
  def ask_user_for(stuff)
    puts "Please give me a #{stuff}"
    gets.chomp
  end

  def display_meals(meals)
    meals.each_with_index do |meal, index|
      puts "#{meal.id}. #{meal.name} - £#{meal.price}"
    end
  end
end
