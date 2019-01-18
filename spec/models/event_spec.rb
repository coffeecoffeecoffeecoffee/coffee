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

  describe "#before_save" do
    it "calls #ensure_updated_foursquare_venue_data" do
      event = build(:event)
      expect(event).to receive(:ensure_updated_foursquare_venue_data) # rubocop:disable RSpec/MessageSpies
      event.save
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

  describe "#image_url" do
    it "returns the venue's image_url" do
      event = build(:event)

      venue = event.venue
      expect(event.image_url).to eq(venue.image_url)
    end
  end

  describe "#venue_url" do
    it "returns the venue's url" do
      event = build(:event)

      venue = event.venue
      expect(event.venue_url).to eq(venue.url)
    end
  end

  describe "#formatted_local_time" do
    it "returns the formatted time in the group time zone" do
      event = build(:event, start_at: Time.parse("2017-12-13T16:30:00Z").utc)
      expect(event.formatted_local_time).to eq("Wednesday, December 13, 2017, 8:30 AM")
    end
  end

  describe "#ensure_updated_foursquare_venue_data", vcr: { cassette_name: :foursquare_venue_details } do
    context "when the record is brand new" do
      it "fetches new foursquare_venue_data" do
        event = build(:event, foursquare_venue_data: nil)

        expect(event.foursquare_venue_data).to be_nil
        event.save
        expect(event.foursquare_venue_data).not_to be_nil
      end
    end

    context "when the record already exists and the foursquare_venue_id changes" do
      it "deletes existing foursquare_venue_data" do
        event = create(:event)

        expect(event.foursquare_venue_data).not_to be_nil
        # Set to 123 here to prevent from being able to fetch real Foursquare data
        event.update(foursquare_venue_id: "123")
        event.save
        expect(event.foursquare_venue_data).to be_nil
      end

      it "fetches new foursquare_venue_data " do
        event = create(:event, foursquare_venue_data: {})

        expect(event.foursquare_venue_data).not_to be_nil
        event.update(foursquare_venue_id: "4feddd79d86cd6f22dc171a9")
        event.save
        expect(event.foursquare_venue_data).not_to eq({})
      end
    end
  end
end
