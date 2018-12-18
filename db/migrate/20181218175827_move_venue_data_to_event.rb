class MoveVenueDataToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :foursquare_venue_id, :string
    add_column :events, :foursquare_venue, :jsonb

    Venue.find_each do |venue|
      venue.events.each do |event|
        event.update_columns( # rubocop:disable Rails/SkipsModelValidations
          foursquare_venue_id: venue.foursquare_id,
          foursquare_venue: venue.foursquare_venue
        )
      end
    end

    change_column_null :events, :foursquare_venue_id, false
  end
end
