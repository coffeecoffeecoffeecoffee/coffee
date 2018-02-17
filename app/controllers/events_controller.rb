class EventsController < ApplicationController
  def index
    @events = Event.future_or_now.decorate
    @past_events = Event.past.decorate
  end
end
