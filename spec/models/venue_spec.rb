require 'rails_helper'

RSpec.describe Venue, type: :model do
  it { is_expected.to have_one(:event).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:foursquare_id) }

  describe '#address' do
    # TODO: Remove this when address is added back to Venue
    it 'returns nil (for now)' do
      venue = build(:venue)
      expect(venue.address).to be_nil
    end
  end
end
