require 'sinatra'
require 'sinatra/json'
require './services/calendar_service.rb'

get '/' do
  @event = CalendarService.new.next_event
  erb :index
end

get '/api/events' do
  json CalendarService.new.events
end

get '/api/events/future' do
  json CalendarService.new.future_events
end
