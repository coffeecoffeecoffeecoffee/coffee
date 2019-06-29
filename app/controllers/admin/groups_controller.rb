module Admin
  class GroupsController < Admin::ApplicationController
    def find_resource(param)
      Group.friendly.find(param)
    end

    def scoped_resource
      return Group if current_user.superadmin?

      Group.with_member(current_user)
    end
  end
end
