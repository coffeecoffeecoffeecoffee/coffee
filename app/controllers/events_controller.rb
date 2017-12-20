class EventsController < ApplicationController
  def index
    @events = Event.future_or_now.decorate
  end
end
