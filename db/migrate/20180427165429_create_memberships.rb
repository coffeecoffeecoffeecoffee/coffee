class CreateMemberships < ActiveRecord::Migration[5.2]
  def change
    create_table :memberships, id: :uuid do |t| # rubocop:disable Style/SymbolProc
      t.timestamps
    end
    add_reference :memberships, :group, type: :uuid, foreign_key: true, null: false # rubocop:disable Rails/NotNullColumn
    add_reference :memberships, :user, type: :uuid, foreign_key: true, null: false # rubocop:disable Rails/NotNullColumn
  end
end
