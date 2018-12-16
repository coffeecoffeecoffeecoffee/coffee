class CreateVenues < ActiveRecord::Migration[5.2]
  def change
    create_table :venues, id: :uuid do |t|
      t.string :foursquare_id, null: false
      t.string :name
      t.string :foursquare_url
      t.string :image_url

      t.timestamps
    end

    add_column :events, :venue_id, :uuid

    reversible do |direction|
      direction.up do
        Event.find_each do |e|
          venue = Venue.create!(foursquare_id: e.venue_foursquare_id)
          e.update_columns(venue_id: venue.id) # rubocop:disable Rails/SkipsModelValidations
        end
      end
    end

    change_column_null :events, :venue_id, false
  end
end
