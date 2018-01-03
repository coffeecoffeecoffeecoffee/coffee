class EventDecorator < ApplicationDecorator
  delegate_all

  decorates_association :group

  delegate :name_with_emoji, to: :group, prefix: true

  def time
    start_at_pacific.strftime('%A, %B %e, %Y, %-I:%M %p')
  end

  private

  def start_at_pacific
    start_at.in_time_zone('US/Pacific')
  end
end
