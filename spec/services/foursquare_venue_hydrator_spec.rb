require "rails_helper"

describe FoursquareVenueHydrator do
  describe ".run" do
    it "hydrates the event venue", vcr: { cassette_name: :foursquare_venue_details } do
      event = build(:event, :with_nil_physical_venue_data)
      described_class.run(event.location)

      expect(event.location.foursquare_data).not_to be_nil
    end

    it "doesn't hydrate if there is an error contacting Foursquare" do
      WebMock.stub_request(:get, /.*/).to_return(status: 200)

      event = build(:event, :with_nil_physical_venue_data)
      described_class.run(event.location)

      expect(event.location.foursquare_data).to be_nil

      WebMock.reset!
    end
  end
end
