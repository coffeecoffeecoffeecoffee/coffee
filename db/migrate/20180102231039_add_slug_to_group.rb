class AddSlugToGroup < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :slug, :string

    Group.find_each(&:save)

    change_column_null :groups, :slug, false
    add_index :groups, :slug, unique: true
  end
end
