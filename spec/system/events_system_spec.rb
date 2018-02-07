require 'rails_helper'

describe 'Events' do
  describe '/' do
    context 'when future events exist' do
      it 'shows all upcoming events', vcr: { cassette_name: :foursquare_venue_details } do
        start_at = Time.parse('2017-12-13T16:30:00Z').utc
        allow(Time).to receive(:now).and_return(start_at)
        group = create(:group)
        create(:future_event, group: group, start_at: start_at)
        create(:future_event,
               location: 'Blue Bottle Coffee',
               group: group,
               start_at: start_at)

        visit '/'
        expect(page).to have_text('Wednesday, December 13, 2017, 8:30 AM')
        expect(page).to have_link('The Mill', href: 'https://foursquare.com/v/the-mill/4feddd79d86cd6f22dc171a9')
        expect(page).to have_link('☕ SF iOS Coffee', href: group_path(group))

        expect(page).to have_text('Blue Bottle Coffee')
      end
    end

    context 'when future events do not exist' do
      it 'shows an unscheduled message' do
        visit '/'
        expect(page).to have_text('There are no events scheduled. Check back later.')
      end
    end

    describe 'SEO' do
      describe 'Open Graph' do
        it 'has valid Open Graph tags' do
          visit '/'
          expect(page).to have_css('meta[property="og:title"][content="Find an Event | Gather"]', visible: false)
          expect(page).to have_css('meta[property="og:type"][content="website"]', visible: false)
          expect(page).to have_css('meta[property="og:url"][content="http://127.0.0.1/"]', visible: false)
          expect(page).to have_css('meta[property="og:description"][content="Find an event happening near you on Gather."]', visible: false)
        end

        context 'when @events contains an event' do
          it 'shows the first future event image', vcr: { cassette_name: :foursquare_venue_details } do
            create(:future_event)
            visit '/'
            image_url = 'https://igx.4sqi.net/img/general/612x612/403777_tR60tUZMVoJ5Q5ylr8hQnp0pgZTy5BOQLqydzAoHWiA.jpg'
            expect(page).to have_css("meta[property='og:image'][content='#{image_url}']", visible: false)
          end
        end

        context 'when @events is empty' do
          it 'shows the default image' do
            visit '/'
            expect(page).to have_css('meta[property="og:image"][content="http://127.0.0.1/apple-touch-icon.png"]', visible: false)
          end
        end
      end
    end
  end
end
