class VenueHydrator
  # TODO: Clean up this class. Rename, etc.
  include HTTParty

  base_uri "https://api.foursquare.com/v2"

  def self.run(event)
    new(event).hydrate_venue
  end

  def initialize(event)
    @event = event
  end

  def hydrate_venue
    response = self.class.get("/venues/#{@event.foursquare_venue_id}", query: auth)
    body = JSON.parse(response.body, symbolize_names: true)
    foursquare_venue = body[:response][:venue]
    @event.foursquare_venue = foursquare_venue
  rescue StandardError
    nil
  end

  private

  def auth
    {
      client_id: Rails.application.credentials.foursquare[:client_id],
      client_secret: Rails.application.credentials.foursquare[:client_secret],
      v: "20180101"
    }
  end
end
