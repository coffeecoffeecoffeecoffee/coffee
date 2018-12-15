module ApplicationHelper
  def current_user
    current_user_decorated
  end

  def og_events_image_url
    image_url_for_event(Event.next)
  end

  def og_group_image_url
    image_url_for_event(@group.events.future_or_now.first)
  end

  private

  def image_url_for_event(event)
    return (request.base_url + '/apple-touch-icon.png') unless event

    event.venue.image_url
  end
end
