require 'active_support'

class Event
  attr_reader :datetime, :location

  def initialize(calendar_event)
    @datetime = calendar_event.dtstart
    @location = calendar_event.location.force_encoding('iso-8859-1').encode('utf-8')
  end

  def to_json(_options)
    {
      date: @datetime.to_date.to_formatted_s(:long),
      time: @datetime.strftime('%-I:%M%p'),
      location: @location
    }.to_json
  end
end
