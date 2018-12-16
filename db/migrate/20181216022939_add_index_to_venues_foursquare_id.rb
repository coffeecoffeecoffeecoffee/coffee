class AddIndexToVenuesFoursquareId < ActiveRecord::Migration[5.2]
  def change
    add_index :venues, :foursquare_id, unique: true
  end
end
