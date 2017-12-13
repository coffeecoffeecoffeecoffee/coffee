class HomeController < ApplicationController
  def index
    @event = Event.next
  end
end
