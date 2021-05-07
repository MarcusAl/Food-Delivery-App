class Customer
  attr_reader :name, :address
  attr_accessor :id

  def initialize(attr = {})
    @id = attr[:id] || 0
    @name = attr[:name] || 'No_Name'
    @address = attr[:address] || 'No_Address'
  end
end
