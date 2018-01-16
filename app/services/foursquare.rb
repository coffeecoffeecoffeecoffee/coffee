class Foursquare
  include HTTParty

  base_uri 'https://api.foursquare.com/v2'

  def venue(id)
    response = self.class.get("/venues/#{id}", query: auth)
    body = JSON.parse(response.body, symbolize_names: true)
    body[:response][:venue]
  end

  private

  def auth
    {
      client_id: ENV.fetch('FOURSQUARE_CLIENT_ID'),
      client_secret: ENV.fetch('FOURSQUARE_CLIENT_SECRET'),
      v: '20180101'
    }
  end
end
