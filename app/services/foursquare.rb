class Foursquare
  include HTTParty

  base_uri 'https://api.foursquare.com/v2'

  def venue(id)
    response = self.class.get("/venues/#{id}", query: auth)
    body = JSON.parse(response.body, symbolize_names: true)
    body[:response][:venue]
  rescue StandardError
    nil
  end

  private

  def auth
    {
      client_id: Rails.application.credentials.foursquare[:client_id],
      client_secret: Rails.application.credentials.foursquare[:client_secret],
      v: '20180101'
    }
  end
end
