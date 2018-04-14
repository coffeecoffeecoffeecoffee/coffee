class Venue
  attr_reader :foursquare_id, :name, :foursquare_url, :image_url, :address

  def initialize(params = {})
    @foursquare_id = params[:id]
    @name = params[:name]
    @foursquare_url = params[:canonicalUrl]
    best_photo = params[:bestPhoto]
    @image_url = best_photo[:prefix] + best_photo[:width].to_s + 'x' + best_photo[:height].to_s + best_photo[:suffix]
    @address = ([@name] + params[:location][:formattedAddress]).join("\, ").remove(" (#{params[:location][:crossStreet]})")
  end

  def self.find(foursquare_id)
    cache_key = "venues/#{foursquare_id}"
    venue = Rails.cache.fetch(cache_key, expires_in: 12.hours) do
      foursquare_venue = Foursquare.new.venue(foursquare_id)
      Venue.new(foursquare_venue) if foursquare_venue.present?
    end
    Rails.cache.delete(cache_key) if venue.nil?
    venue
  end
end
