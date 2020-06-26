json.extract! event, :id, :group_id, :name, :image_url, :start_at, :end_at
json.venue do
  if event.venue.present?
    json.name event.venue.name
    json.location do
      json.latitude event.venue.latitude
      json.longitude event.venue.longitude
    end
  else
    json.null!
  end
end
json.extract! event, :is_online, :online_event_url
