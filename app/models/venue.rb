class Venue
  attr_reader :foursquare_id, :name, :foursquare_url, :image_url

  def initialize(params = {})
    @foursquare_id = params[:id]
    @name = params[:name]
    @foursquare_url = params[:canonicalUrl]
    best_photo = params[:bestPhoto]
    @image_url = best_photo[:prefix] + best_photo[:width].to_s + 'x' + best_photo[:height].to_s + best_photo[:suffix]
  end

  def self.find(foursquare_id)
    Rails.cache.fetch("venues/#{foursquare_id}", expires_in: 12.hours) do
      foursquare_venue = Foursquare.new.venue(foursquare_id)
      Venue.new(foursquare_venue)
    end
  end
end
