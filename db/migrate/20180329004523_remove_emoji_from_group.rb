class RemoveEmojiFromGroup < ActiveRecord::Migration[5.1]
  def change
    remove_column :groups, :emoji, :string
  end
end
