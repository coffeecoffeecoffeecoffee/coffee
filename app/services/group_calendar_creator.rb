class GroupCalendarCreator
  def initialize(group)
    @group = group
  end

  def to_ical
    events = @group.events

    calendar = Icalendar::Calendar.new
    events.each do |event|
      calendar_event = Icalendar::Event.new
      calendar_event.dtstart = event.start_at
      calendar_event.dtend = event.end_at
      calendar_event.summary = "#{@group.name}: #{event.location}"
      calendar.add_event(calendar_event)
    end
    calendar.to_ical
  end
end
