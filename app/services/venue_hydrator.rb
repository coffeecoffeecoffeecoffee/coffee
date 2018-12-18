class VenueHydrator
  include HTTParty

  base_uri "https://api.foursquare.com/v2"

  def self.run(venue)
    new(venue).hydrate_venue
  end

  def initialize(venue)
    @venue = venue
  end

  def hydrate_venue
    response = self.class.get("/venues/#{@venue.foursquare_id}", query: auth)
    body = JSON.parse(response.body, symbolize_names: true)
    foursquare_venue = body[:response][:venue]
    photo = foursquare_venue[:bestPhoto]

    @venue.foursquare_venue = foursquare_venue
    @venue.name = foursquare_venue[:name]
    @venue.foursquare_url = foursquare_venue[:canonicalUrl]
    @venue.image_url = photo[:prefix] + photo[:width].to_s + "x" + photo[:height].to_s + photo[:suffix]
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
