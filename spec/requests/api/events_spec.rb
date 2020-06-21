require "rails_helper"

RSpec.describe "Events", type: :request do
  describe "GET /groups/:group_id/events" do
    it "returns a list of events for the specified group ordered by most future first" do
      group = create(:group)
      future_event = create(:future_event, group: group)
      now_event = create(:now_event, group: group)
      past_event = create(:past_event, group: group)
      really_future_event = create(:really_future_event, group: group)
      create(:event)

      get api_group_events_url(group_id: group.id)

      expect(response).to have_json_size(4)

      event_ids = JSON.parse(response.body).map { |e| e["id"] }
      expect(event_ids).to eq([
                                really_future_event.id,
                                future_event.id,
                                now_event.id,
                                past_event.id
                              ])
    end
  end
end
