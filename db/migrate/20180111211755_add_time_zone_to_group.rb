class AddTimeZoneToGroup < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :time_zone, :string

    Group.all { |g| g.update(time_zone: 'America/Los_Angeles') }

    change_column_null :groups, :time_zone, false
  end
end
