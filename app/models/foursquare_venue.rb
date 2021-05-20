class FoursquareVenue
  def initialize(foursquare_data)
    @foursquare_data = {}
    return if foursquare_data.nil?

    @foursquare_data = foursquare_data.symbolize_keys
  end

  def name
    @foursquare_data[:name]
  end

  def url
    "https://foursquare.com/v/#{@foursquare_data[:id]}"
  end

  def image_url
    photo = @foursquare_data[:bestPhoto]
    return nil if photo.nil?

    photo.symbolize_keys!
    "#{photo[:prefix]}#{photo[:width]}x#{photo[:height]}#{photo[:suffix]}"
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
    location = @foursquare_data[:location]
    return {} if location.nil?

    location.symbolize_keys
  end
end
