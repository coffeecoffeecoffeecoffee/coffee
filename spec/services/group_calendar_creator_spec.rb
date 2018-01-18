require 'rails_helper'

describe GroupCalendarCreator do
  describe '#to_ical' do
    it 'creates an ical with all events' do
      group = create(:group)
      create_list(:future_event, 3, group: group)
      last_event = create(:event, group: group, location: 'Sightglass Coffee', location_url: 'https://sightglasscoffee.com')

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
      expect(calendar_event.location).to eq('Sightglass Coffee')
      expect(calendar_event.url.to_s).to eq('https://sightglasscoffee.com')
      expect(calendar_event.x_apple_structured_location.first).to eq('Sightglass Coffee')
    end
  end
end
