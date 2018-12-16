class AddEmojiToGroup < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :emoji, :string, null: false, default: "☕"
  end
end
