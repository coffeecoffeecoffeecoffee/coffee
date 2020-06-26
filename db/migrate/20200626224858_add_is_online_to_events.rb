class AddIsOnlineToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :is_online, :bool, null: false, default: false
    rename_column :events, :online_venue_url, :online_event_url
  end
end
