class AddVenueToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :venue_foursquare_id, :string, null: false, default: ''
    change_column_default :events, :venue_foursquare_id, from: '', to: nil
  end
end
