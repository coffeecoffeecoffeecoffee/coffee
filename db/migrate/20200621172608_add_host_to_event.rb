class AddHostToEvent < ActiveRecord::Migration[6.0]
  def change
    add_reference :events, :host, type: :uuid, foreign_key: { to_table: :users }
  end
end
