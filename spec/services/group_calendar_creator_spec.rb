require 'rails_helper'

describe GroupCalendarCreator do
  describe '#to_ical' do
    it 'creates an ical with all events' do
      group = create(:group)
      events = create_list(:future_event, 3, group: group)

      ical = GroupCalendarCreator.new(group).to_ical
      calendar_events = Icalendar::Event.parse(ical)

      expect(calendar_events.count).to eq(3)

      event = events.first
      calendar_event = calendar_events.first
      expect(calendar_event.dtstart.to_time.to_i).to eq(event.start_at.to_i)
      expect(calendar_event.dtend.to_time.to_i).to eq(event.end_at.to_i)
    end
  end
end
