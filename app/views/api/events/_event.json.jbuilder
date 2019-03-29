# TODO: Sometime after March 2019, remove venue_url once Roderic updates the app
json.extract! event, :id, :group_id, :name, :venue_url, :image_url, :start_at, :end_at
json.venue do
  json.url event.venue.url
  json.location do
    json.formatted_address event.venue.address
  end
end
