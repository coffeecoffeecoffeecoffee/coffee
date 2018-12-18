class AddFoursquareVenueToVenue < ActiveRecord::Migration[5.2]
  def change
    add_column :venues, :foursquare_venue, :jsonb
  end
end
