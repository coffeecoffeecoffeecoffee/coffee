require 'rails_helper'

RSpec.describe NullVenue, type: :model do
  describe '.initialize' do
    it 'initializes a venue with everything nil' do
      venue = NullVenue.new
      expect(venue.foursquare_id).to be_nil
      expect(venue.image_url).to be_nil
    end
  end
end
