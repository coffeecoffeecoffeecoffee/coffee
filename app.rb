require 'sinatra'
require 'sinatra/json'
require './services/calendar_service.rb'

get '/' do
  event = CalendarService.new.next_event
  date = event.datetime.to_date.to_formatted_s(:long)
  time = event.datetime.strftime('%-I:%M%p')
  "The next iOS coffee will be at #{event.location} at #{time} on #{date}."
end

get '/api/events' do
  json CalendarService.new.events
end

get '/api/events/future' do
  json CalendarService.new.future_events
end
