class EventsController < ApplicationController
  before_action :set_group, only: :show

  def show
    event = @group.events.upcoming.first
    @event = event.present? ? event.decorate : nil
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end
end
