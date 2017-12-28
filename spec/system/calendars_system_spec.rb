require 'rails_helper'

describe 'Calendars' do
  describe 'groups/:id/ical' do
    it 'generates an ics file for the group' do
      group = create(:group)
      create_list(:future_event, 3, group: group)

      visit group_ical_path(group)

      body = page.body
      calendar = Icalendar::Calendar.parse(body).first
      expect(calendar.events.count).to eq(3)
    end
  end
end
