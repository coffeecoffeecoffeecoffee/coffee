class GroupsController < ApplicationController
  def index
    @groups = Group.all.decorate
  end

  def show
    @group = Group.friendly.find(params[:id]).decorate
    @events = @group.events.future_or_now.decorate
    @past_events = @group.events.past.decorate
  end
end
