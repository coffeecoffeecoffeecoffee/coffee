require 'rails_helper'

describe 'Groups' do
  context 'when a future event for the specified group exists' do
    it 'shows all upcoming events' do
      start_at = Time.parse('2017-12-13T16:30:00Z').utc
      allow(Time).to receive(:now).and_return(start_at)
      group = create(:group)
      create(:future_event, group: group, start_at: start_at)
      create(:future_event,
             location: 'Blue Bottle Coffee',
             location_url: 'https://bluebottlecoffee.com',
             group: group,
             start_at: start_at)

      visit group_path(group)
      expect(page).to have_text('Wednesday, December 13, 2017, 8:30 AM')
      expect(page).to have_link('The Mill', href: 'http://www.themillsf.com')
      expect(page).to have_link('SF iOS Coffee ☕', href: group_path(group))

      expect(page).to have_link('Blue Bottle Coffee', href: 'https://bluebottlecoffee.com')
    end

    it 'does not show upcoming events for other groups' do
      group = create(:group)
      other_group = create(:group)
      create(:future_event, group: other_group)

      visit group_path(group)
      expect(page).to have_text('There are no events scheduled. Check back later.')
    end
  end

  context 'when a future event for the specified group does not exist' do
    it 'shows an unscheduled message' do
      event = create(:past_event)

      visit group_path(event.group)
      expect(page).to have_text('There are no events scheduled. Check back later.')
    end
  end
end
