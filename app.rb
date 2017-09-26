require 'sinatra'
require 'sinatra/json'
require './services/calendar_service.rb'

get '/' do
  ['☕', '🍺'].sample
end

get '/events' do
  json CalendarService.new.events
end

get '/events/future' do
  json CalendarService.new.future_events
end
