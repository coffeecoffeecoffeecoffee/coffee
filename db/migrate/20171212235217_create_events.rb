class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events, id: :uuid do |t|
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false
      t.string :location, null: false
      t.string :location_url, null: false

      t.timestamps
    end
  end
end
