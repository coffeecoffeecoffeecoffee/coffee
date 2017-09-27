require 'active_support'
require 'pry'

class Event
  attr_reader :datetime, :location

  def initialize(calendar_event)
    @datetime = calendar_event.dtstart.utc
    @location = calendar_event.location.force_encoding('iso-8859-1').encode('utf-8')
  end

  def to_json(_options)
    {
      datetime: @datetime,
      location: @location
    }.to_json
  end
end
