require 'sinatra'
require 'sinatra/json'
require './services/calendar_service.rb'

set :public_folder, Proc.new { File.join(root, "static") }

get '/' do
  event = CalendarService.new.next_event
  datetime = event.datetime.in_time_zone('US/Pacific')
  @date = datetime.to_date.to_formatted_s(:long)
  @time = datetime.strftime('%-I:%M%p')
  @location = event.location
  @foursquare_url = event.foursquare_url
  erb :index
end

get '/api/events' do
  json CalendarService.new.events
end

get '/api/events/future' do
  json CalendarService.new.future_events
end
