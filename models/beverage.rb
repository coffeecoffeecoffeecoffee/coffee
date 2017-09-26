require 'chronic'

class Beverage
  attr_accessor :name, :date

  def initialize(type)
    date_string = type == :coffee ? 'wednesday 8:30AM' : 'thursday 8PM'
    @name = "iOS #{type.to_s.capitalize}"
    @date = Chronic.parse(date_string)
  end

  def to_json(_options)
    {
      name: @name,
      date: @date
    }.to_json
  end
end
