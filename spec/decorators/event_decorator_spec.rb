require 'rails_helper'

describe EventDecorator do
  describe '#image_url' do
    it 'delegates to venue', vcr: { cassette_name: :foursquare_venue_details } do
      event = build(:event).decorate
      expect(event.image_url).to eq('https://igx.4sqi.net/img/general/612x612/403777_tR60tUZMVoJ5Q5ylr8hQnp0pgZTy5BOQLqydzAoHWiA.jpg')
    end
  end

  describe '#foursquare_url' do
    it 'delegates to venue', vcr: { cassette_name: :foursquare_venue_details } do
      event = build(:event).decorate
      expect(event.foursquare_url).to eq('https://foursquare.com/v/the-mill/4feddd79d86cd6f22dc171a9')
    end
  end

  describe '#time' do
    it 'returns the formatted start time in the group time zone' do
      start_at = Time.parse('2017-12-13T16:30:00Z').utc
      event = build(:event, start_at: start_at).decorate
      expect(event.time).to eq('Wednesday, December 13, 2017, 8:30 AM')
    end
  end
end
