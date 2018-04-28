require 'rails_helper'

RSpec.describe EventReminderJob, type: :job do
  describe '.schedule_24_hours_before_event' do
    it 'schedules the job for 24 hours before the event start date' do
      ActiveJob::Base.queue_adapter = :test
      event = create(:event, start_at: Time.current + 5.days)

      expect { EventReminderJob.schedule_24_hours_before_event(event) }.to have_enqueued_job.at(event.start_at - 24.hours)
    end
  end

  describe '#perform' do
    it 'sends an event reminder to all group members' do
      group = create(:group, users: create_list(:user, 2))
      event = create(:event, group: group)

      expect(EventMailer).to receive(:reminder).exactly(2).times.and_call_original
      EventReminderJob.perform_now(event)
    end
  end
end
