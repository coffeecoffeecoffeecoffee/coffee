require 'rails_helper'

describe 'Home' do
  context 'when a future event exists' do
    it 'shows the next event' do
      event = create(:future_event)

      visit '/'
      start_at = event.start_at_pacific
      expect(page).to have_text("The next event will be at #{event.location} at #{start_at.strftime('%-I:%M%p')} on #{start_at.to_date.to_formatted_s(:long)}. ☕")
      expect(page).to have_link(event.location, href: event.location_url)
    end
  end

  context 'when a future event does not exist' do
    it 'shows an unscheduled message' do
      visit '/'
      expect(page).to have_text('The next event has not been scheduled. Check back later. ☕')
    end
  end
end
