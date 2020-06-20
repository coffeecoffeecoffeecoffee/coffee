class FoursquareVenueHydrator
  include HTTParty

  base_uri "https://api.foursquare.com/v2"

  def self.run(location)
    new(location).hydrate_venue
  end

  def initialize(location)
    @location = location
  end

  def hydrate_venue
    response = self.class.get("/venues/#{@location.foursquare_id}", query: auth)
    body = JSON.parse(response.body, symbolize_names: true)
    @location.foursquare_data = body[:response][:venue]
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
