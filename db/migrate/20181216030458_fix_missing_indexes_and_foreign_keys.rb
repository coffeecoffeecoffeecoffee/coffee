class FixMissingIndexesAndForeignKeys < ActiveRecord::Migration[5.2]
  def change
    add_index :events, :venue_id
    add_foreign_key :events, :venues
  end
end
