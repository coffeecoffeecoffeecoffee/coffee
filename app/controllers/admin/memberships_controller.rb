module Admin
  class MembershipsController < Admin::ApplicationController
    def show_action?(_action, _resource)
      current_user.superadmin?
    end
  end
end
