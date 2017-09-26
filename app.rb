require 'sinatra'
require 'sinatra/json'
require './services/calendar_service.rb'

get '/' do
  ['☕', '🍺'].sample
end

get '/beverages' do
  json CalendarService.new.events
end

get '/beverages/future' do
  json CalendarService.new.future_events
end
