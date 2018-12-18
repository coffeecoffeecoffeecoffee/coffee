require "rails_helper"

describe VenueHydrator do
  describe ".run" do
    it "hydrates the event venue", vcr: { cassette_name: :foursquare_venue_details } do
      event = build(:event_without_foursquare_venue)
      described_class.run(event)

      expect(event.foursquare_venue).not_to be_nil
    end

    it "doesn't hydrate if there is an error contacting Foursquare" do
      WebMock.stub_request(:get, /.*/).to_return(status: 200)

      event = build(:event_without_foursquare_venue)
      described_class.run(event)

      expect(event.foursquare_venue).to be_nil

      WebMock.reset!
    end
  end
end
