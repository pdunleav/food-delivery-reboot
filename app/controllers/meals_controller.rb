require_relative '../views/meal_view'

class MealsController
  def initialize(meal_repository)
    @view = MealView.new
    @meal_repo = meal_repository
  end

  def add
    # get name and price from user
    name = @view.ask_user_for("name")
    price = @view.ask_user_for("price").to_i
    # instantiate a new meal with that data
    meal = Meal.new(name: name, price: price)
    # push new meal to our repo
    @meal_repo.add(meal)
  end

  def list
    meals = @meal_repo.all
    @view.display(meals)
  end
end
