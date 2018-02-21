require 'rails_helper'

describe GroupCalendarCreator do
  describe '#to_ical' do
    it 'creates an ical with all events', vcr: { cassette_name: :foursquare_venue_details, allow_playback_repeats: true } do
      group = create(:group)
      create_list(:future_event, 3, group: group)
      last_event = create(:event, group: group, location: 'Sightglass Coffee')

      ical = GroupCalendarCreator.new(group).to_ical
      calendar = Icalendar::Calendar.parse(ical).first

      expect(calendar.events.count).to eq(4)
      expect(calendar.prodid).to eq('-//Gather/Gather/EN')
      expect(calendar.x_wr_calname.first).to eq(group.name)

      calendar_event = calendar.events.last
      expect(calendar_event.summary).to eq('SF iOS Coffee at Sightglass Coffee')
      expect(calendar_event.dtstart).to eq(last_event.start_at.change(usec: 0))
      expect(calendar_event.dtstart.to_s).to include('UTC')
      expect(calendar_event.dtend).to eq(last_event.end_at.change(usec: 0))
      expect(calendar_event.dtend.to_s).to include('UTC')
      expect(calendar_event.location).to eq("The Mill\, 736 Divisadero St\, San Francisco, CA 94117\, United States")
      expect(calendar_event.url.to_s).to eq('https://foursquare.com/v/the-mill/4feddd79d86cd6f22dc171a9')
      expect(calendar_event.x_apple_structured_location.first).to eq(calendar_event.location)
    end
  end
end
