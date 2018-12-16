class RemoveVenueFoursqaureIdFromEvents < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :venue_foursquare_id, :string
  end
end
