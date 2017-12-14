class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups, id: :uuid do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_reference :events, :group, type: :uuid, foreign_key: true
  end
end
