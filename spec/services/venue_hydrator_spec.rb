require "rails_helper"

describe VenueHydrator do
  describe ".run" do
    it "hydrates the venue", vcr: { cassette_name: :foursquare_venue_details } do
      venue = build(:venue, foursquare_id: "4feddd79d86cd6f22dc171a9", name: nil, foursquare_url: nil, image_url: nil)
      described_class.run(venue)

      expect(venue.name).to eq("The Mill")
      expect(venue.foursquare_url).to eq("https://foursquare.com/v/the-mill/4feddd79d86cd6f22dc171a9")
      expect(venue.image_url).to eq("https://igx.4sqi.net/img/general/612x612/403777_tR60tUZMVoJ5Q5ylr8hQnp0pgZTy5BOQLqydzAoHWiA.jpg")
    end

    it "doesn't hydrate if there is an error contacting Foursquare" do
      WebMock.stub_request(:get, /.*/).to_return(status: 200)

      venue = build(:venue, name: nil)
      described_class.run(venue)

      expect(venue.name).to be_nil

      WebMock.reset!
    end
  end
end
