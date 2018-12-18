class RenameFoursquareVenueToFoursquareVenueData < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :foursquare_venue, :foursquare_venue_data
  end
end
