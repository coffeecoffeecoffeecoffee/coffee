require "rails_helper"

RSpec.describe "Events", type: :request do
  describe "GET /groups/:group_id/events" do
    it "returns a list of events for the specified group" do
      group = create(:group)
      events = create_list(:event, 2, group: group)

      get api_group_events_url(group_id: group.id)

      expect(response).to have_http_status(:ok)
      expect(response.body).to have_json_for(events, only: %i[id name])
    end
  end
end
