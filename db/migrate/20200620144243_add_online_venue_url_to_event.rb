class AddOnlineVenueUrlToEvent < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :online_venue_url, :string
  end
end
