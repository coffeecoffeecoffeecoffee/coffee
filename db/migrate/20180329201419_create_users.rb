class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :twitter, null: false

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
