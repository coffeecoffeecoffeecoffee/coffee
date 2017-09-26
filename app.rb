require 'sinatra'
require 'sinatra/json'
require './services/calendar_service.rb'

get '/' do
  ['☕', '🍺'].sample
end

get '/api/events' do
  json CalendarService.new.events
end

get '/api/events/future' do
  json CalendarService.new.future_events
end
