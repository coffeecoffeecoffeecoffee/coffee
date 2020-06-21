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
      # TODO: There are a lot of null venue checks here. Fix this with
      # something like a NullVenue or alternative

      summary = @group.name.to_s
      summary = "#{@group.name} at #{event.venue.name}" unless event.foursquare_venue_id.nil?

      location = event.venue.address || event.online_venue_url

      url = event.online_venue_url
      url = event.venue.url unless event.foursquare_venue_id.nil?

      calendar_event = Icalendar::Event.new
      calendar_event.summary = summary
      calendar_event.description = event.name
      calendar_event.dtstart = Icalendar::Values::DateOrDateTime.new(event.start_at, tzid: event.start_at.zone).call
      calendar_event.dtend = Icalendar::Values::DateOrDateTime.new(event.end_at, tzid: event.end_at.zone).call
      calendar_event.location = location
      calendar_event.url = url
      calendar_event.append_custom_property("X-APPLE-STRUCTURED-LOCATION", event.venue.address) if event.venue.address.present?
      calendar.add_event(calendar_event)
    end

    calendar.to_ical
  end
end
