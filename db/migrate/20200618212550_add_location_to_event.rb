class AddLocationToEvent < ActiveRecord::Migration[6.0]
  def change
    create_table :foursquare_venues, id: :uuid do |t|
      t.string :foursquare_id, null: false
      t.jsonb :foursquare_data
      t.timestamps
    end
    add_index :foursquare_venues, :foursquare_id

    add_column :events, :location_id, :uuid
    add_column :events, :location_type, :string
    add_index :events, %i[location_id location_type]

    reversible do |direction|
      direction.up do
        Event.find_each do |e|
          foursquare_venue = FoursquareVenue.create!(
            foursquare_id: e.foursquare_venue_id,
            foursquare_data: e.foursquare_venue_data
          )
          e.update!(
            location_id: foursquare_venue.id,
            location_type: FoursquareVenue.name
          )
        end
      end
    end
  end
end
