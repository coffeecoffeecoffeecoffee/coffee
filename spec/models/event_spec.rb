require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should belong_to(:group) }

  it { should validate_presence_of(:start_at) }
  it { should validate_presence_of(:end_at) }
  it { should validate_presence_of(:location) }
  it { should validate_presence_of(:group) }
  it { should validate_presence_of(:venue_foursquare_id) }

  describe '.future_or_now' do
    it 'returns all future events' do
      events = create_list(:future_event, 3)
      expect(Event.future_or_now).to eq(events)
    end

    it 'returns all events happening now' do
      events = create_list(:now_event, 3)
      expect(Event.future_or_now).to eq(events)
    end

    it 'orders events by closest upcoming event first' do
      later_event = create(:future_event)
      sooner_event = create(:future_event, start_at: later_event.start_at - 1.second)
      expect(Event.future_or_now).to eq([sooner_event, later_event])
    end

    it 'does not return past events' do
      create_list(:past_event, 2)
      expect(Event.future_or_now).to eq([])
    end
  end

  describe '.past' do
    it 'returns all past events with most recent first' do
      past_event = create(:past_event)
      earlier_event = create(:past_event, start_at: past_event.start_at - 1.second)
      more_recent_event = create(:past_event, start_at: past_event.start_at + 1.second)
      expect(Event.past).to eq([more_recent_event, past_event, earlier_event])
    end

    it 'does not return future or now events' do
      create_list(:future_event, 2)
      expect(Event.past).to eq([])
    end
  end

  describe '.next' do
    it 'returns first future event' do
      events = create_list(:future_event, 2) + [create(:past_event)]
      expect(Event.next).to eq(events.first)
    end

    it 'returns nil if there is no future event' do
      expect(Event.next).to be_nil
    end
  end

  describe '#after_create' do
    it 'schedules a reminder for 24 hours before the event' do
      expect(EventReminderJob).to receive(:schedule_24_hours_before_event)
      create(:event)
    end
  end

  describe '#venue' do
    it 'returns the venue for the #venue_foursquare_id', vcr: { cassette_name: :foursquare_venue_details } do
      event = build(:event)
      expect(event.venue).to be_an_instance_of(Venue)
      expect(event.venue.foursquare_id).to eq(event.venue_foursquare_id)
    end
  end
end
