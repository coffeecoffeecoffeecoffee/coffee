class Venuez
  def initialize(foursquare_venue)
    @foursquare_venue = {}
    return if foursquare_venue.nil?

    @foursquare_venue = foursquare_venue.symbolize_keys
  end

  def name
    @foursquare_venue[:name]
  end

  def foursquare_url
    @foursquare_venue[:canonicalUrl]
  end

  def image_url
    photo = @foursquare_venue[:bestPhoto]
    return nil if photo.nil?

    photo.symbolize_keys!
    photo[:prefix] + photo[:width].to_s + "x" + photo[:height].to_s + photo[:suffix]
  end

  def address
    location = @foursquare_venue[:location]
    return nil if location.nil?

    location.symbolize_keys!
    location[:formattedAddress].join(", ")
  end
end
