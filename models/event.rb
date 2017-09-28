require 'active_support'

class Event
  attr_reader :datetime, :location, :foursquare_url

  def initialize(calendar_event)
    @datetime = calendar_event.dtstart.utc
    @location = calendar_event.location.force_encoding('iso-8859-1').encode('utf-8')
    query = { q: @location }.to_query
    @foursquare_url = "https://foursquare.com/explore?#{query}"
  end

  def to_json(_options)
    {
      datetime: @datetime,
      location: @location
    }.to_json
  end
end
