class RemoveLocationUrlFromEvents < ActiveRecord::Migration[5.1]
  def change
    remove_column :events, :location_url, :string
  end
end
