class GroupsController < ApplicationController
  def show
    group = Group.find(params[:id])
    @events = group.events.future_or_now.decorate
    render 'events/index'
  end
end
