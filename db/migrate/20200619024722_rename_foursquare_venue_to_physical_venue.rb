class RenameFoursquareVenueToPhysicalVenue < ActiveRecord::Migration[6.0]
  def change
    rename_table :foursquare_venues, :physical_venues
  end
end
