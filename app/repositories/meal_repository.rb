require_relative '../models/meal'
require 'csv'

class MealRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @meals = []
    @next_id = 1
    load_csv if File.exist?(@csv_file_path)
  end

  def add(meal)
    meal.id = @next_id
    @meals << meal
    @next_id += 1
    save_csv
  end

  def all
    @meals
  end

  def find(id)
    @meals.find { |meal| meal.id == id }
  end

  private

  def load_csv
    # csv_options = { headers: true, header_converters: :symbol}
    CSV.foreach(@csv_file_path, { headers: true, header_converters: :symbol }) do |row|
      row[:id] = row[:id].to_i
      row[:price] = row[:price].to_i
      @meals << Meal.new(row)
      @next_id += 1
    end
  end

  def save_csv
    CSV.open(@csv_file_path, "wb") do |csv|
      csv << ["id", "name", "price"]
      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end
end
