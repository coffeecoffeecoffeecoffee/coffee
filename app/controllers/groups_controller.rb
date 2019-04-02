class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def show
    @group = Group.friendly.find(params[:id])
    @events = @group.events.future_or_now
    @past_events = @group.events.past
    set_meta_tags "apple-itunes-app": "app-id=1458031604"
  end
end
