require "rails_helper"

RSpec.describe Event, type: :model do
  it { is_expected.to belong_to(:group) }

  it { is_expected.to validate_presence_of(:start_at) }
  it { is_expected.to validate_presence_of(:end_at) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:group) }
  it { is_expected.to validate_presence_of(:foursquare_venue_id) }

  describe ".future_or_now" do
    it "returns all future events" do
      events = create_list(:future_event, 3)
      expect(Event.future_or_now).to eq(events)
    end

    it "returns all events happening now" do
      events = create_list(:now_event, 3)
      expect(Event.future_or_now).to eq(events)
    end

    it "orders events by closest upcoming event first" do
      later_event = create(:future_event)
      sooner_event = create(:future_event, start_at: later_event.start_at - 1.second)
      expect(Event.future_or_now).to eq([sooner_event, later_event])
    end

    it "does not return past events" do
      create_list(:past_event, 2)
      expect(Event.future_or_now).to eq([])
    end
  end

  describe ".past" do
    it "returns all past events with most recent first" do
      past_event = create(:past_event)
      earlier_event = create(:past_event, start_at: past_event.start_at - 1.second)
      more_recent_event = create(:past_event, start_at: past_event.start_at + 1.second)
      expect(Event.past).to eq([more_recent_event, past_event, earlier_event])
    end

    it "does not return future or now events" do
      create_list(:future_event, 2)
      expect(Event.past).to eq([])
    end
  end

  describe ".next" do
    it "returns first future event" do
      events = create_list(:future_event, 2) + [create(:past_event)]
      expect(Event.next).to eq(events.first)
    end

    it "returns nil if there is no future event" do
      expect(Event.next).to be_nil
    end
  end

  describe "#venue" do
    context "when foursquare venue details exist" do
      it "returns a venue" do
        event = build(:event)

        expect(event.foursquare_venue_data).not_to be_nil

        venue = event.venue
        expect(venue).not_to be_nil
        expect(venue.name).to eq("The Mill")
      end
    end

    context "when foursquare venue data does not exist" do
      it "returns an empty venue" do
        event = build(:event, foursquare_venue_data: nil)

        venue = event.venue
        expect(venue).not_to be_nil
        expect(venue.name).to be_nil
      end
    end
  end
end
