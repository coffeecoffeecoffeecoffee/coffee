class Venue
  attr_reader :foursquare_id, :name, :foursquare_url, :image_url, :address

  def initialize(params = {})
    @foursquare_id = params[:id]
    @name = params[:name]
    @foursquare_url = params[:canonicalUrl]
    @address = ([@name] + params[:location][:formattedAddress]).join("\, ").remove(" (#{params[:location][:crossStreet]})")
    best_photo = params[:bestPhoto]
    return unless best_photo
    @image_url = best_photo[:prefix] + best_photo[:width].to_s + 'x' + best_photo[:height].to_s + best_photo[:suffix]
  end

  def self.find(foursquare_id)
    cache_key = "venues/#{foursquare_id}"
    venue = Rails.cache.fetch(cache_key, expires_in: 1.week) do
      foursquare_venue = Foursquare.new.venue(foursquare_id)
      Venue.new(foursquare_venue) if foursquare_venue.present?
    end
    if venue.nil?
      Rails.cache.delete(cache_key)
      NullVenue.new
    else
      venue
    end
  end
end
