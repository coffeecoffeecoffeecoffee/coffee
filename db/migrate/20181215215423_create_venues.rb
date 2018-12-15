# rubocop:disable Rails/BulkChangeTable
class CreateVenues < ActiveRecord::Migration[5.2]
  def change
    create_table :venues, id: :uuid do |t|
      t.string :foursquare_id, null: false
      t.string :name, null: false
      t.string :foursquare_url, null: false
      t.string :image_url, null: false

      t.timestamps
    end

    add_column :events, :venue_id, :uuid

    venue = Venue.create!(foursquare_id: '', name: '', foursquare_url: '', image_url: '')

    change_column_null :events, :venue_id, false, venue.id
  end
end
# rubocop:enable Rails/BulkChangeTable
