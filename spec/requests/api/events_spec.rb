require "rails_helper"

RSpec.describe "Events", type: :request do
  describe "GET /groups/:group_id/events" do
    it "returns a list of events for the specified group" do
      group = create(:group)
      create_list(:event, 2, group: group)
      create(:event)

      get api_group_events_url(group_id: group.id)

      expect(response).to match_openapi_spec("/groups/#{group.id}/events", "get")
      expect(response).to have_json_size(2)
    end
  end
end
