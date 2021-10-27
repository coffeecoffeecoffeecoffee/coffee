json.extract! event, :id, :group_id, :name, :image_url
# NOTE: we're forcing RFC3339 here. What are our options to not do this?
json.start_at event.start_at.to_datetime.rfc3339
json.end_at event.end_at.to_datetime.rfc3339
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
