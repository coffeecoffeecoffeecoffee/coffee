require 'rails_helper'

describe GroupCalendarCreator do
  describe '#to_ical' do
    it 'creates an ical with all events' do
      group = create(:group)
      create_list(:future_event, 3, group: group)

      ical = GroupCalendarCreator.new(group).to_ical
      calendar_events = Icalendar::Event.parse(ical)

      expect(calendar_events.count).to eq(3)
    end
  end
end
