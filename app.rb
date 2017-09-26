require 'sinatra'
require 'sinatra/json'
require './services/calendar_service.rb'

get '/' do
  ['☕', '🍺'].sample
end

get '/beverages/:filter' do
  filter = params['filter'].to_sym
  json CalendarService.new.future_events
end
