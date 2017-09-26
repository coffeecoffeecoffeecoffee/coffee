require 'sinatra'

get '/' do
  ['☕', '🍺'].sample
end