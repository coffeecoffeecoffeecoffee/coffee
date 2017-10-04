require 'active_support'

class Event
  attr_reader :datetime, :location, :foursquare_url, :summary, :description

  def initialize(calendar_event)
    @datetime = calendar_event.dtstart.utc
    @location = calendar_event.location.force_encoding('iso-8859-1').encode('utf-8')
    query = { q: @location }.to_query
    @foursquare_url = "https://foursquare.com/explore?#{query}"
    @summary = calendar_event.summary
    @description = calendar_event.description
  end

  def to_json(_options)
    {
      datetime: @datetime,
      location: @location,
      foursquare_url: @foursquare_url,
      summary: @summary,
      description: @description
    }.to_json
  end
end
