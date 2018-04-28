class EventReminderJob < ApplicationJob
  queue_as :default

  def self.schedule_24_hours_before_event(event)
    time = event.start_at - 24.hours
    EventReminderJob.set(wait_until: time).perform_later(event)
  end

  def perform(event)
    event.group.users.each do |user|
      EventMailer.reminder(event, user).deliver_later
    end
  end
end
