class MoveFoursquareIdToVenue < ActiveRecord::Migration[5.2]
  def change
    reversible do |direction|
      direction.up do
        Event.find_each do |e|
          venue = Venue.create!(foursquare_id: e.venue_foursquare_id)
          e.update_columns(venue_id: venue.id) # rubocop:disable Rails/SkipsModelValidations
        end
      end
    end
    remove_column :events, :venue_foursquare_id, :string
  end
end
