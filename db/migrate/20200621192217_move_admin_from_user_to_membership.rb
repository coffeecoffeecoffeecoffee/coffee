class MoveAdminFromUserToMembership < ActiveRecord::Migration[6.0]
  def change
    add_column :memberships, :admin, :bool, null: false, default: false

    # make all existing group members admins since the only memberships that
    # exist right now are for admins
    Membership.all.each { |m| m.update!(admin: true) }

    remove_column :users, :admin, :bool, null: false, default: false
  end
end
