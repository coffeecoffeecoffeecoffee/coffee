class EventDecorator < ApplicationDecorator
  delegate_all

  decorates_association :group

  delegate :name_with_emoji, to: :group, prefix: true
  delegate :image_url, to: :venue

  def time
    start_at_local.strftime('%A, %B %e, %Y, %-I:%M %p')
  end

  def start_at_local
    in_group_time_zone(start_at)
  end

  def end_at_local
    in_group_time_zone(end_at)
  end

  private

  def in_group_time_zone(time)
    time_zone = group.time_zone
    time.in_time_zone(time_zone)
  end
end
