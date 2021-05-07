class Meal
  attr_reader :name, :price
  attr_accessor :id

  def initialize(attr = {})
    @id = attr[:id] || 0
    @name = attr[:name] || 'Empty'
    @price = attr[:price] || 0
  end
end
