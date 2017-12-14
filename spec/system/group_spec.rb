require 'rails_helper'

describe 'Group' do
  context 'when a future event for the specified group exists' do
    it 'shows the next event' do
      start_at = Time.parse('2017-12-13T16:30:00Z').utc
      allow(Time).to receive(:now).and_return(start_at)
      event = create(:future_event, start_at: start_at)

      visit "groups/#{event.group.id}"
      expect(page).to have_text('The next event will be at The Mill at 8:30AM on December 13. ☕')
      expect(page).to have_link('The Mill', href: 'http://www.themillsf.com')
    end

    it 'uses the group emoji' do
      group = create(:group, emoji: '🍺')
      event = create(:future_event, group: group)

      visit "groups/#{event.group.id}"
      expect(page).to have_text('🍺')
      expect(page).to_not have_text('☕')
    end
  end

  context 'when a future event for the specified group does not exist' do
    it 'shows an unscheduled message' do
      event = create(:past_event)

      visit "groups/#{event.group.id}"
      expect(page).to have_text('The next event has not been scheduled. Check back later. ☕')
    end
  end
end
