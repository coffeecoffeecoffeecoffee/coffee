module Api
  class GroupsController < ApplicationController
    def index
      @groups = Group.active
    end
  end
end
