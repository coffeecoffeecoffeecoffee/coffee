class RenameEventLocationToName < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :location, :name
  end
end
