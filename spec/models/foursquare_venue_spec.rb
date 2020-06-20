require "rails_helper"

RSpec.describe FoursquareVenue, type: :model do
  let(:foursquare_venue) do
    event = build(:event, :with_foursquare_venue)
    FoursquareVenue.new(event.foursquare_venue_data)
  end

  describe "#name" do
    it "returns the name from foursquare data" do
      expect(foursquare_venue.name).to eq("The Mill")
    end
  end

  describe "#url" do
    it "returns the venue's url" do
      expect(foursquare_venue.url).to eq("https://foursquare.com/v/4feddd79d86cd6f22dc171a9")
    end
  end

  describe "#image_url" do
    it "returns the image URL from foursquare data" do
      expect(foursquare_venue.image_url).to eq("https://igx.4sqi.net/img/general/612x612/403777_tR60tUZMVoJ5Q5ylr8hQnp0pgZTy5BOQLqydzAoHWiA.jpg")
    end
  end

  describe "#address" do
    it "returns the address from foursquare data" do
      expect(foursquare_venue.address).to eq("736 Divisadero St (btwn Grove St & Fulton St), San Francisco, CA 94117, United States")
    end
  end

  describe "#latitude" do
    it "returns the latitude from foursquare data" do
      expect(foursquare_venue.latitude).to eq(37.77632881728594)
    end
  end

  describe "#longitude" do
    it "returns the longitude from foursquare date" do
      expect(foursquare_venue.longitude).to eq(-122.43802428245543)
    end
  end
end
