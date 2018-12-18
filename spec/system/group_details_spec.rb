require "rails_helper"

describe "Group details" do
  context "when a future event for the specified group exists" do
    it "shows all upcoming events ordered by upcoming first", vcr: { cassette_name: :foursquare_venue_details } do
      start_at = Time.parse("2017-12-13T16:30:00Z").utc
      allow(Time).to receive(:now).and_return(start_at)
      group = create(:group)
      create(:future_event,
             name: "Created First, Happens Second",
             group: group,
             start_at: start_at + 1.day)
      create(:future_event,
             name: "Created Second, Happens First",
             group: group,
             start_at: start_at)

      visit group_path(group)

      within ".event:nth-of-type(1)" do
        expect(page).to have_text("Created Second, Happens First")
        expect(page).to have_text("Wednesday, December 13, 2017, 8:30 AM")
        expect(page).to have_link("Created Second, Happens First", href: "https://foursquare.com/v/the-mill/4feddd79d86cd6f22dc171a9")
      end

      within ".event:nth-of-type(2)" do
        expect(page).to have_text("Created First, Happens Second")
        expect(page).to have_text("Thursday, December 14, 2017, 8:30 AM")
        expect(page).to have_link("Created First, Happens Second", href: "https://foursquare.com/v/the-mill/4feddd79d86cd6f22dc171a9")
      end
    end

    it "has a link to subscribe to the calendar using the id (not slug)" do
      group = create(:group)
      visit group_path(group)
      expect(page).to have_link("Subscribe to Calendar", href: "webcal://127.0.0.1/#{group.id}/ical")
    end

    it "does not show upcoming events for other groups" do
      group = create(:group)
      other_group = create(:group)
      create(:future_event, group: other_group, name: "Blue Bottle Coffee")

      visit group_path(group)
      expect(page).not_to have_text("Blue Bottle Coffee")
    end
  end

  context "when a future event for the specified group does not exist" do
    context "when past events exist" do
      it "shows five past events", vcr: { cassette_name: :foursquare_venue_details } do
        group = create(:group)
        create_list(:past_event, 3, group: group)
        visit group_path(group)
        expect(page).to have_text("Past Events")
      end

      it "orders past events with the most recent at the top", vcr: { cassette_name: :foursquare_venue_details } do
        group = create(:group)
        create(:past_event, group: group, name: "Old Name", start_at: group.created_at - 1.second)
        create(:past_event, group: group, name: "More Recent Name", start_at: group.created_at + 1.second)
        visit group_path(group)
        expect(page.body.index("More Recent Name")).to be < page.body.index("Old Name")
      end
    end

    context "when no past events exist" do
      it "does not show any events" do
        group = create(:group)
        visit group_path(group)
        expect(page).not_to have_text("Past Events")
      end
    end
  end

  describe "SEO" do
    it "has the group name in the title" do
      group = create(:group, name: "Dogs are Awesome")

      visit group_path(group)
      expect(page).to have_selector("title", text: "Dogs are Awesome | Coffee", visible: false)
    end

    describe "Open Graph" do
      it "has valid Open Graph tags" do
        group = create(:group)
        visit group_path(group)
        expect(page).to have_css('meta[property="og:title"][content="SF iOS Coffee | Coffee"]', visible: false)
        expect(page).to have_css('meta[property="og:type"][content="website"]', visible: false)
        expect(page).to have_css("meta[property=\"og:url\"][content=\"#{url_for group}\"]", visible: false)
        expect(page).to have_css('meta[property="og:description"][content="SF iOS Coffee is hosting their events on Coffee."]', visible: false)
      end

      context "when a group has a future event" do
        it "shows the first future event image", vcr: { cassette_name: :foursquare_venue_details } do
          group = create(:group)
          create(:future_event, group: group)
          visit group_path(group)
          image_url = "https://igx.4sqi.net/img/general/612x612/403777_tR60tUZMVoJ5Q5ylr8hQnp0pgZTy5BOQLqydzAoHWiA.jpg"
          expect(page).to have_css("meta[property='og:image'][content='#{image_url}']", visible: false)
        end
      end

      context "when a group has no future events" do
        it "shows the default image" do
          group = create(:group)
          visit group_path(group)
          expect(page).to have_css('meta[property="og:image"][content="http://127.0.0.1/apple-touch-icon.png"]', visible: false)
        end
      end
    end

    it "can find the group by a slug", vcr: { cassette_name: :foursquare_venue_details } do
      group = create(:group, name: "Sluggable Group")
      create(:event, group: group, name: "Blue Bottle Coffee")

      visit "groups/sluggable-group"
      expect(page).to have_text("Blue Bottle Coffee")
    end

    it "redirects /groups/:id to /:id" do
      create(:group, slug: "slug")

      visit "/groups/slug"
      expect(page).to have_current_path("/slug")
    end
  end
end
