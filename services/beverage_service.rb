require './models/beverage'

class BeverageService
  def initialize
    @beverages = [Beverage.new(:coffee), Beverage.new(:beer)]
  end

  def call(filter)
    @beverages.sort_by(&:date) if filter == :future
  end
end
