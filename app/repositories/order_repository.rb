require 'csv'
require_relative '../models/order'

class OrderRepository
  def initialize(csv_file_path, meal_repository, customer_repository, employee_repository)
    @csv_file_path = csv_file_path
    @orders = []
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @next_id = 1
    load_csv if File.exist?(@csv_file_path)
  end

  def all_undelivered_orders
    @orders.reject { |order| order.delivered? }

    # undelivered_orders = []
    # @orders.each do |order|
    #   undelivered_orders << if !order.delivered?
    # end
  end

  def create(order)
    order.id = @next_id
    @orders << order
    @next_id += 1
    save_csv
  end

  def mark_as_delivered(order)
    order.deliver!
    save_csv
  end

  def my_undelivered_orders(employee)
    @orders.select { |order| order.employee == employee && !order.delivered? }
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      id = row[:id].to_i
      meal = @meal_repository.find(row[:meal_id].to_i)
      customer = @customer_repository.find(row[:customer_id].to_i)
      employee = @employee_repository.find(row[:employee_id].to_i)
      delivered = row[:delivered] == 'true'
      @orders << Order.new(id: id, meal: meal, customer: customer, employee: employee, delivered: delivered)
    end
    @next_id = @orders.last.id + 1 unless @orders.empty?
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << ["id","meal_id","customer_id","employee_id", "delivered"]
      @orders.each do |order|
        csv << [ order.id, order.meal.id, order.customer.id, order.employee.id, order.delivered? ]
      end
    end
  end
end
