require 'icalendar'
require 'net/http'
require './models/event'

class CalendarService
  CALENDAR_URL = 'https://calendar.google.com/calendar/ical/ho60q57pauegr2ki4v9hhspvdo%40group.calendar.google.com/public/basic.ics'.freeze

  def events
    cal_uri = URI.parse(CALENDAR_URL)
    cal_file = Net::HTTP.get(cal_uri)
    cal = Icalendar::Calendar.parse(cal_file).first
    cal.events.sort_by(&:dtstart).reverse.first(10).map { |e| Event.new(e) }
  end

  def future_events
    events.select { |e| e.datetime.future? }
  end

  def next_event
    future_events.last
  end
end
