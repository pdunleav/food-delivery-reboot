require_relative 'app/repositories/employee_repository'

employee_repository = EmployeeRepository.new('data/employees.csv')

p employee_repository
