require_relative '../models/employee'
require 'csv'

class EmployeeRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @employees = []
    @next_id = 1
    load_csv if File.exist?(@csv_file_path)
  end

  def add(employee)
    employee.id = @next_id
    @employees << employee
    @next_id += 1
    save_csv
  end

  def all
    @employees
  end

  def find_by_username(username)
    # look in the list of employees for the one with same username
    return @employees.find { |employee| employee.username == username }
  end

  private

  def load_csv
    # csv_options = { headers: true, header_converters: :symbol}
    CSV.foreach(@csv_file_path, { headers: true, header_converters: :symbol }) do |row|
      row[:id] = row[:id].to_i
      @employees << Employee.new(row)
      @next_id += 1
    end
  end

  def save_csv
    CSV.open(@csv_file_path, "wb") do |csv|
      csv << ["id", "username", "password", "role"]
      @employees.each do |employee|
        csv << [employee.id, employee.username, employee.password, employee.role]
      end
    end
  end
end
