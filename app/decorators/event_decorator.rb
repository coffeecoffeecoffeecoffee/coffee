class EventDecorator < ApplicationDecorator
  delegate_all

  def date
    start_at_pacific.strftime('%B %e')
  end

  delegate :emoji, to: :group

  def start_time
    start_at_pacific.strftime('%-I:%M%p')
  end

  private

  def start_at_pacific
    start_at.in_time_zone('US/Pacific')
  end
end
