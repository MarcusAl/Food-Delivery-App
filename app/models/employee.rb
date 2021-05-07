class Employee
  attr_reader :username, :password, :role
  attr_accessor :id

  def initialize(attr = {})
    @id = attr[:id] || 0
    @username = attr[:username] || 'No User'
    @password = attr[:password] || 'No Password'
    @role = attr[:role] || 'Role'
  end

  def manager?
    @role == 'manager'
  end

  def rider?
    @role == 'rider'
  end
end
