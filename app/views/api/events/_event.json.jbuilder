json.extract! event, :id, :group_id, :name, :image_url, :start_at, :end_at
json.venue do
  json.name event.venue.name
  json.location do
    json.formatted_address event.venue.address
    json.latitude event.venue.latitude
    json.longitude event.venue.longitude
  end
  json.url event.venue_url
end
json.venue_v2 do
  json.type event.location_type_with_underscores
  json.location do
    json.formatted_address event.venue.address
    json.latitude event.venue.latitude
    json.longitude event.venue.longitude
  end
end
