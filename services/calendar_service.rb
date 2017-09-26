require 'icalendar'
require 'net/http'
require './models/event'

class CalendarService
  CALENDAR_URL = 'https://calendar.google.com/calendar/ical/ho60q57pauegr2ki4v9hhspvdo%40group.calendar.google.com/public/basic.ics'.freeze

  def future_events
    cal_uri = URI.parse(CALENDAR_URL)
    cal_file = Net::HTTP.get(cal_uri)
    cal = Icalendar::Calendar.parse(cal_file).first
    cal.events.map { |e| Event.new(e) }.select { |e| e.datetime.future? }
  end
end
