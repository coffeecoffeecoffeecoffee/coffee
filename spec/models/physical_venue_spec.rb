require "rails_helper"

RSpec.describe PhysicalVenue, type: :model do
  it { is_expected.to have_one(:event).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:foursquare_id) }
end
