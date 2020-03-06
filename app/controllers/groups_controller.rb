class GroupsController < ApplicationController
  def index
    @groups = Group.active
  end

  def show
    @group = Group.friendly.find(params[:id])
    @events = @group.events.future_or_now
    @past_events = @group.events.past
  end
end
