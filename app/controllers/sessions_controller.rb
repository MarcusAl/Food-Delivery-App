require_relative '../views/views'

class SessionsController
  def initialize(employee_repo)
    @employee_repo = employee_repo
    @view = View.new
  end

  def login
    # ask for username
    username = @view.ask_user("Username?")
    # ask for password
    password = @view.ask_user("Password?")
    # find employee by username
    user = @employee_repo.find_by_username(username)
    # check if employee password matches entered password
    if password == user&.password
      # if yes then return the user
      return user
    else
      # if no then give error feedback and retry
      @view.user_error
      login
    end
  end
end
