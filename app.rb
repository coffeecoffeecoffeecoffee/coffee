require 'sinatra'
require 'sinatra/json'
require './services/beverage_service.rb'

get '/' do
  ['☕', '🍺'].sample
end

get '/beverages/:filter' do
  filter = params['filter'].to_sym
  json BeverageService.new.call(filter)
end
