require 'rails_helper'

RSpec.describe Venue, type: :model do
  describe '.initialize' do
    it 'formats the address correctly', vcr: { cassette_name: :foursquare_venue_details } do
      foursquare_id = '4feddd79d86cd6f22dc171a9'
      address = "The Mill\, 736 Divisadero St\, San Francisco, CA 94117\, United States"
      expect(Venue.find(foursquare_id).address).to eq(address)
    end
  end

  describe '.find' do
    context 'when successful' do
      it 'finds the venue with the specified id', vcr: { cassette_name: :foursquare_venue_details } do
        foursquare_id = '4feddd79d86cd6f22dc171a9'
        expect(Venue.find(foursquare_id).foursquare_id).to eq(foursquare_id)
      end

      it 'caches the result', vcr: { cassette_name: :foursquare_venue_details } do
        foursquare_id = '4feddd79d86cd6f22dc171a9'
        cache_key = "venues/#{foursquare_id}"

        store = ActiveSupport::Cache.lookup_store(:memory_store)
        allow(Rails).to receive(:cache).and_return(store)

        expect(Rails.cache.exist?(cache_key)).to be_falsey
        Venue.find(foursquare_id)
        expect(Rails.cache.exist?(cache_key)).to be_truthy
      end
    end

    context 'when unsuccessful' do
      it 'returns nil' do
        expect(Venue.find(nil)).to be_nil
      end

      it 'does not cache the nil result', vcr: { cassette_name: :foursquare_venue_details } do
        foursquare_id = '4feddd79d86cd6f22dc171a9'
        cache_key = "venues/#{foursquare_id}"

        store = ActiveSupport::Cache.lookup_store(:memory_store)
        allow(Rails).to receive(:cache).and_return(store)

        # Disable outgoing conn, should fail and not cache nil
        WebMock.stub_request(:get, /.*/)

        expect(Rails.cache.exist?(cache_key)).to be_falsey
        Venue.find(foursquare_id)
        expect(Rails.cache.exist?(cache_key)).to be_falsey

        WebMock.reset!

        # Outgoing conn enabled via VCR, should get response and cache
        Venue.find(foursquare_id)
        expect(Rails.cache.exist?(cache_key)).to be_truthy
      end
    end
  end
end
