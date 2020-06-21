class AllowNullGroupOnEvent < ActiveRecord::Migration[6.0]
  def change
    change_column_null :events, :group_id, true
  end
end
