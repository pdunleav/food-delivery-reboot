require_relative '../views/session_view'

class SessionsController
  def initialize(employee_repository)
    @view = SessionView.new
    @repository = employee_repository
  end

  def sign_in
    # 1. Ask user for username
    username = @view.ask_user_for(:username)
    # 2. Ask user for password
    password = @view.ask_user_for(:password)
    # 3. Find the user with the username given
    employee = @repository.find_by_username(username)

    if employee
      if employee.password == password
        return employee
      else
        @view.wrong_password
        sign_in
      end
    else
      @view.user_doesnt_exist
      sign_in # recursive method call
    end
  end
end
