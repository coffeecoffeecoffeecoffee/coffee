class Venue
  def initialize(foursquare_venue)
    @foursquare_venue = {}
    return if foursquare_venue.nil?

    @foursquare_venue = foursquare_venue.symbolize_keys
  end

  def name
    @foursquare_venue[:name]
  end

  def url
    @foursquare_venue[:canonicalUrl]
  end

  def image_url
    photo = @foursquare_venue[:bestPhoto]
    return nil if photo.nil?

    photo.symbolize_keys!
    photo[:prefix] + photo[:width].to_s + "x" + photo[:height].to_s + photo[:suffix]
  end

  def address
    formatted_address = location[:formattedAddress]
    return nil if formatted_address.nil?

    formatted_address.join(", ")
  end

  def latitude
    location[:lat]
  end

  def longitude
    location[:lng]
  end

  private

  def location
    location = @foursquare_venue[:location]
    return {} if location.nil?

    location.symbolize_keys
  end
end
