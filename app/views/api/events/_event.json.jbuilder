json.extract! event, :id, :group_id, :name, :image_url, :start_at, :end_at
json.venue do
  json.name event.foursquare_venue.name
  json.location do
    json.formatted_address event.foursquare_venue.address
    json.latitude event.foursquare_venue.latitude
    json.longitude event.foursquare_venue.longitude
  end
  json.url event.foursquare_venue_url
end
json.venue_v2 do
  json.type event.location_type_with_underscores
  json.location do
    json.formatted_address event.foursquare_venue.address
    json.latitude event.foursquare_venue.latitude
    json.longitude event.foursquare_venue.longitude
  end
end
