require 'rails_helper'

RSpec.describe EventMailer, type: :mailer do
  let(:from_email) { 'noreply@coffeecoffeecoffee.coffee' }

  describe '#reminder' do
    let(:group) do
      create(:group,
             users: build_list(:user, 1),
             events: build_list(:event, 1))
    end
    let(:user) { group.users.first }
    let(:event) { group.events.first }

    it 'renders the headers' do
      mail = EventMailer.reminder(event, user)

      expected_subject_line = "Tomorrow: #{group.name} is at #{event.location}"

      expect(mail.subject).to eq(expected_subject_line)
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq([from_email])
    end

    it 'renders the body' do
      mail = EventMailer.reminder(event, user)
      decorated_event = event.decorate

      expect(mail.body.encoded).to match(user.twitter)
      expect(mail.body.encoded).to match(decorated_event.time)
      expect(mail.body.encoded).to match(group.name)
      expect(mail.body.encoded).to match(event.location)
    end
  end
end
