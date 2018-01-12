require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should belong_to(:group) }

  it { should validate_presence_of(:start_at) }
  it { should validate_presence_of(:end_at) }
  it { should validate_presence_of(:location) }
  it { should validate_presence_of(:location_url) }
  it { should allow_value('https://coffeecoffeecoffee.coffee').for(:location_url) }
  it { should_not allow_value('not a url').for(:location_url) }
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

    it 'does not return past events' do
      create_list(:past_event, 2)
      expect(Event.future_or_now).to eq([])
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
end
