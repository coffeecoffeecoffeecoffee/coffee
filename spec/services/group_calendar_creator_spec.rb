require "rails_helper"

describe GroupCalendarCreator do
  describe "#to_ical" do
    it "creates an ical with all events", vcr: { cassette_name: :foursquare_venue_details, allow_playback_repeats: true } do
      group = create(:group)
      create_list(:future_event, 3, group: group)
      last_event = create(:event, :with_foursquare_venue, group: group, name: "Coffup")

      ical = described_class.new(group).to_ical
      calendar = Icalendar::Calendar.parse(ical).first

      expect(calendar.events.count).to eq(4)
      expect(calendar.prodid).to eq("-//Coffee/Coffee/EN")
      expect(calendar.x_wr_calname.first).to eq(group.name)

      calendar_event = calendar.events.last
      expect(calendar_event.summary).to eq("SF iOS Coffee at The Mill")
      expect(calendar_event.description).to eq("Coffup")
      expect(calendar_event.dtstart).to eq(last_event.start_at.change(usec: 0))
      expect(calendar_event.dtstart.to_s).to include("UTC")
      expect(calendar_event.dtend).to eq(last_event.end_at.change(usec: 0))
      expect(calendar_event.dtend.to_s).to include("UTC")
      expect(calendar_event.location).to eq("736 Divisadero St (btwn Grove St & Fulton St), San Francisco, CA 94117, United States")
      expect(calendar_event.url.to_s).to eq("https://foursquare.com/v/4feddd79d86cd6f22dc171a9")
      expect(calendar_event.x_apple_structured_location.first).to eq(calendar_event.location)
    end

    context "with hydrated venue" do
      it "creates an ical with all events" do
        event = create(:event, :with_group, :with_foursquare_venue)
        calendar = calendar_for_group(event.group)
        calendar_event = calendar.events.last

        expect(calendar_event.summary).to eq("SF iOS Coffee at The Mill")
        expect(calendar_event.location).to eq("736 Divisadero St (btwn Grove St & Fulton St), San Francisco, CA 94117, United States")
        expect(calendar_event.url.to_s).to eq("https://foursquare.com/v/4feddd79d86cd6f22dc171a9")
      end
    end

    context "with nil venue" do
      it "creates an ical with all events" do
        event = create(:event, :with_group)
        calendar = calendar_for_group(event.group)
        calendar_event = calendar.events.last

        expect(calendar_event.summary).to eq("SF iOS Coffee")
        expect(calendar_event.location).to be_nil
        expect(calendar_event.url).to be_nil
        expect(calendar_event.x_apple_structured_location.first).to be_nil
      end
    end

    context "with online venue" do
      it "creates an ical with all events" do
        event = create(:event, :with_group, :with_online_venue)
        calendar = calendar_for_group(event.group)
        calendar_event = calendar.events.last

        expect(calendar_event.summary).to eq("SF iOS Coffee")
        expect(calendar_event.location).to eq("https://meet.google.com/coffeecoffeecoffeecoffee")
        expect(calendar_event.url.to_s).to eq("https://meet.google.com/coffeecoffeecoffeecoffee")
        expect(calendar_event.x_apple_structured_location.first).to be_nil
      end
    end
  end

  def calendar_for_group(group)
    ical = described_class.new(group).to_ical
    Icalendar::Calendar.parse(ical).first
  end
end
