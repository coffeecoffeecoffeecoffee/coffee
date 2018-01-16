require 'rails_helper'

describe 'Calendars' do
  describe ':id/ical' do
    it 'generates an ics file for the group' do
      group = create(:group)
      create_list(:future_event, 3, group: group)

      visit group_ical_path(group)

      body = page.body
      calendar = Icalendar::Calendar.parse(body).first
      expect(calendar.events.count).to eq(3)
    end
  end

  describe '/groups/:id/ical' do
    it 'redirects to /:id/ical' do
      group = create(:group)

      visit "/groups/#{group.id}/ical"
      expect(current_path).to eq("/#{group.id}/ical")
    end
  end
end
