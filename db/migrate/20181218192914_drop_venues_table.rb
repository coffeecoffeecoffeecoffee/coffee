class DropVenuesTable < ActiveRecord::Migration[5.2]
  def change
    remove_reference :events, :venue, type: :uuid, foreign_key: true, null: false

    drop_table :venues, id: :uuid do |t|
      t.string "foursquare_id", null: false
      t.string "name"
      t.string "foursquare_url"
      t.string "image_url"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.jsonb "foursquare_venue"
      t.index ["foursquare_id"], name: "index_venues_on_foursquare_id", unique: true
    end
  end
end
