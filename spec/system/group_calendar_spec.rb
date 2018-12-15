require 'rails_helper'

describe 'Group calendar' do
  it 'generates an ics file for the group', vcr: { cassette_name: :foursquare_venue_details } do
    group = create(:group)
    create_list(:future_event, 3, group: group)

    visit group_ical_path(group)

    body = page.body
    calendar = Icalendar::Calendar.parse(body).first
    expect(calendar.events.count).to eq(3)
  end

  describe 'SEO' do
    describe '/groups/:id/ical' do
      it 'redirects to /:id/ical' do
        group = create(:group)

        visit "/groups/#{group.id}/ical"
        expect(page).to have_current_path("/#{group.id}/ical")
      end
    end
  end
end
