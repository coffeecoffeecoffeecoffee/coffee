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
      summary = @group.name.to_s
      address = nil
      location = event.online_venue_url
      url = event.online_venue_url

      if event.venue
        summary = "#{@group.name} at #{event.venue.name}"
        address = event.venue.address
        location = address
        url = event.venue.url
      end

      calendar_event = Icalendar::Event.new
      calendar_event.summary = summary
      calendar_event.description = event.name
      calendar_event.dtstart = Icalendar::Values::DateOrDateTime.new(event.start_at, tzid: event.start_at.zone).call
      calendar_event.dtend = Icalendar::Values::DateOrDateTime.new(event.end_at, tzid: event.end_at.zone).call
      calendar_event.location = location
      calendar_event.url = url
      calendar_event.append_custom_property("X-APPLE-STRUCTURED-LOCATION", address) if address.present?
      calendar.add_event(calendar_event)
    end

    calendar.to_ical
  end
end
