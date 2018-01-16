class Venue
  attr_reader :foursquare_id, :name

  def initialize(params = {})
    @foursquare_id = params[:id]
    @name = params[:name]
  end

  def self.find(foursquare_id)
    foursquare_venue = Foursquare.new.venue(foursquare_id)
    Venue.new(foursquare_venue)
  end
end
