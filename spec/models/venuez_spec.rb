require "rails_helper"

RSpec.describe Venuez, type: :model do
  let(:venue) do
    foursquare_venue = build(:event).foursquare_venue
    Venuez.new(foursquare_venue)
  end

  describe "#name" do
    it "returns the name from foursquare data" do
      expect(venue.name).to eq("The Mill")
    end
  end

  describe "#foursquare_url" do
    it "returns the foursquare URL from foursquare data" do
      expect(venue.foursquare_url).to eq("https://foursquare.com/v/the-mill/4feddd79d86cd6f22dc171a9")
    end
  end

  describe "#image_url" do
    it "returns the image URL from foursquare data" do
      expect(venue.image_url).to eq("https://igx.4sqi.net/img/general/612x612/403777_tR60tUZMVoJ5Q5ylr8hQnp0pgZTy5BOQLqydzAoHWiA.jpg")
    end
  end

  describe "#address" do
    it "returns the address from foursquare data" do
      expect(venue.address).to eq("736 Divisadero St (btwn Grove St & Fulton St), San Francisco, CA 94117, United States")
    end
  end
end
