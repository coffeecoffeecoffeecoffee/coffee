require 'rails_helper'

describe 'Events' do
  context 'when future events exist' do
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

      visit '/'
      expect(page).to have_text('Wednesday, December 13, 2017, 8:30 AM')
      expect(page).to have_link('The Mill', href: 'http://www.themillsf.com')
      expect(page).to have_link('SF iOS Coffee ☕', href: group_path(group))

      expect(page).to have_link('Blue Bottle Coffee', href: 'https://bluebottlecoffee.com')
    end
  end

  context 'when future events do not exist' do
    it 'shows an unscheduled message' do
      visit '/'
      expect(page).to have_text('There are no events scheduled. Check back later.')
    end
  end
end
