require 'rails_helper'

describe GroupCalendarCreator do
  describe '#to_ical' do
    it 'creates an ical with all events' do
      group = create(:group)
      create_list(:future_event, 3, group: group)
      last_event = create(:event, group: group, location: 'Sightglass Coffee')

      ical = GroupCalendarCreator.new(group).to_ical
      calendar = Icalendar::Calendar.parse(ical).first

      expect(calendar.events.count).to eq(4)
      expect(calendar.prodid).to eq('-//Coffee/Coffee/EN')
      expect(calendar.x_wr_calname.first).to eq(group.name)

      calendar_event = calendar.events.last
      expect(calendar_event.summary).to eq('SF iOS Coffee at Sightglass Coffee')
      expect(calendar_event.dtstart.to_time.to_i).to eq(last_event.start_at.to_i)
      expect(calendar_event.dtend.to_time.to_i).to eq(last_event.end_at.to_i)
      expect(calendar_event.location).to eq('Sightglass Coffee')
    end
  end
end
