class GroupCalendarCreator
  def initialize(group)
    @group = group
  end

  def to_ical
    events = @group.events

    calendar = Icalendar::Calendar.new
    calendar.prodid = "-//Coffee/Coffee/EN"
    calendar.append_custom_property("X-WR-CALNAME", @group.name)

    events.each do |event|
      calendar_event = Icalendar::Event.new
      calendar_event.summary = "#{@group.name} at #{event.foursquare_venue.name}"
      calendar_event.description = event.name
      calendar_event.dtstart = Icalendar::Values::DateOrDateTime.new(event.start_at, tzid: event.start_at.zone).call
      calendar_event.dtend = Icalendar::Values::DateOrDateTime.new(event.end_at, tzid: event.end_at.zone).call
      calendar_event.location = event.foursquare_venue.address
      calendar_event.url = event.foursquare_venue_url
      calendar_event.append_custom_property("X-APPLE-STRUCTURED-LOCATION", event.foursquare_venue.address) if event.foursquare_venue.address.present?
      calendar.add_event(calendar_event)
    end

    calendar.to_ical
  end
end
