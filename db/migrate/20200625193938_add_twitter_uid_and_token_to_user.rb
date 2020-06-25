class AddTwitterUidAndTokenToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :twitter_uid, :string
    add_column :users, :token, :string

    User.all.each do |u|
      u.validate
      u.save!
    end

    change_column_null :users, :token, false
    add_index :users, :token, unique: true
  end
end
