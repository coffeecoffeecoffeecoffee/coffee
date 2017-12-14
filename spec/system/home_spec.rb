require 'rails_helper'

describe 'Home' do
  context 'when a future event exists' do
    it 'shows the next event' do
      start_at = Time.parse('2017-12-13T16:30:00Z').utc
      allow(Time).to receive(:now).and_return(start_at)
      create(:future_event, start_at: start_at)

      visit '/'
      expect(page).to have_text('The next event will be at The Mill at 8:30AM on December 13, 2017. ☕')
      expect(page).to have_link('The Mill', href: 'http://www.themillsf.com')
    end
  end

  context 'when a future event does not exist' do
    it 'shows an unscheduled message' do
      visit '/'
      expect(page).to have_text('The next event has not been scheduled. Check back later. ☕')
    end
  end
end
