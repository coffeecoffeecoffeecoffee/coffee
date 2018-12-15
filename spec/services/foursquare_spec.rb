require 'rails_helper'

describe Foursquare do
  describe '#venue' do
    it 'finds the venue with the specified id', vcr: { cassette_name: :foursquare_venue_details } do
      id = '4feddd79d86cd6f22dc171a9'
      venue = described_class.new.venue(id)
      expect(venue[:id]).to eq(id)
    end

    it 'returns nil if there is an error contacting Foursquare' do
      WebMock.stub_request(:get, /.*/).to_return(status: 200)
      venue = described_class.new.venue(nil)
      expect(venue).to be_nil
      WebMock.reset!
    end
  end
end
