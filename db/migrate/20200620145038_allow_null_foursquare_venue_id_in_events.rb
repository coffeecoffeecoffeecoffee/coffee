class AllowNullFoursquareVenueIdInEvents < ActiveRecord::Migration[6.0]
  def change
    change_column_null :events, :foursquare_venue_id, true
  end
end
