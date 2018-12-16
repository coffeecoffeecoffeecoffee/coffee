class EnforceNullInDb < ActiveRecord::Migration[5.1]
  def change
    change_column_default :groups, :emoji, from: "☕", to: nil
    change_column_null :events, :group_id, false
  end
end
