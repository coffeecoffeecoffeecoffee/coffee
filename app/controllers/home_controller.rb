class HomeController < ApplicationController
  def index
    event = Event.next
    @event = event.present? ? event.decorate : nil
    render 'groups/show'
  end
end
