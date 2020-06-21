class DisallowNullEventHost < ActiveRecord::Migration[6.0]
  def change
    change_column_null :events, :host_id, false
  end
end
