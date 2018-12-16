class EventDecorator < ApplicationDecorator
  delegate_all

  decorates_association :group

  delegate :image_url, to: :venue, allow_nil: true
  delegate :foursquare_url, to: :venue, allow_nil: true

  def time
    start_at_local.strftime("%A, %B %e, %Y, %-I:%M %p")
  end

  private

  def start_at_local
    in_group_time_zone(start_at)
  end

  def in_group_time_zone(time)
    time_zone = group.time_zone
    time.in_time_zone(time_zone)
  end
end
