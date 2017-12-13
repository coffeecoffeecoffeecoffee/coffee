require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should validate_presence_of(:start_at) }
  it { should validate_presence_of(:end_at) }
  it { should validate_presence_of(:location) }
  it { should validate_presence_of(:location_url) }
  it { should allow_value('https://coffeecoffeecoffee.coffee').for(:location_url) }
  it { should_not allow_value('not a url').for(:location_url) }

  describe '.upcoming' do
    it 'returns all future events' do
      events = create_list(:future_event, 3)
      expect(Event.upcoming).to eq(events)
    end

    it 'does not return past events' do
      create_list(:past_event, 2)
      expect(Event.upcoming).to eq([])
    end
  end

  describe '.next' do
    it 'returns first future event' do
      events = create_list(:future_event, 2) + [create(:past_event)]
      expect(Event.next).to eq(events.first)
    end
  end

  describe '#start_at_pacific' do
    it 'returns start_at in the US/Pacific time zone' do
      event = build(:event)
      time = event.start_at.to_s(:time)
      time_pacific = event.start_at.in_time_zone('US/Pacific').to_s(:time)
      expect(time).to_not eq(time_pacific)
      expect(time_pacific).to eq(event.start_at_pacific.to_s(:time))
    end
  end
end
