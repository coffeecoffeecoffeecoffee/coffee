# rubocop:disable Rails/BulkChangeTable
class AddTimeZoneToGroup < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :time_zone, :string, null: false, default: 'America/Los_Angeles'
    change_column_default :groups, :time_zone, from: 'America/Los_Angeles', to: nil
  end
end
# rubocop:enable Rails/BulkChangeTable
