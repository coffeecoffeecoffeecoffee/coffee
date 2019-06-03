class GroupsController < ApplicationController
  def index
    @groups = Group.order(Arel.sql("CASE WHEN slug = 'wwdc' THEN 1 ELSE 2 END"))
  end

  def show
    @group = Group.friendly.find(params[:id])
    @events = @group.events.future_or_now
    @past_events = @group.events.past
  end
end
