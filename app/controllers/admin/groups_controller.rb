module Admin
  class GroupsController < Admin::ApplicationController
    def find_resource(param)
      Group.friendly.find(param)
    end
  end
end
