class GroupCalendarCreator
  def initialize(group)
    @group = group
  end

  def to_ical
    events = @group.events

    calendar = Icalendar::Calendar.new
    calendar.prodid = '-//Coffee/Coffee/EN'
    calendar.append_custom_property('X-WR-CALNAME', @group.name)

    events.each do |event|
      calendar_event = Icalendar::Event.new
      calendar_event.summary = "#{@group.name} at #{event.location}"
      calendar_event.dtstart = Icalendar::Values::DateOrDateTime.new(event.start_at, tzid: event.start_at.zone).call
      calendar_event.dtend = Icalendar::Values::DateOrDateTime.new(event.end_at, tzid: event.end_at.zone).call
      calendar_event.location = event.venue.address
      calendar_event.url = event.venue.foursquare_url
      calendar_event.append_custom_property('X-APPLE-STRUCTURED-LOCATION', event.venue.address) if event.venue.address.present?
      calendar.add_event(calendar_event)
    end

    calendar.to_ical
  end
end
