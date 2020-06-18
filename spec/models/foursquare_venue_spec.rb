require "rails_helper"

RSpec.describe FoursquareVenue, type: :model do
  it { is_expected.to have_many(:events).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:foursquare_id) }
end
