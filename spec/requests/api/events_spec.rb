require "rails_helper"

RSpec.describe "Events", type: :request do
  describe "GET /groups/:group_id/events" do
    it "returns a list of events for the specified group" do
      group = create(:group)
      events = create_list(:event, 2, group: group)

      get api_group_events_url(group_id: group.id)

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq(events_json(events))
    end
  end

  private

  # TODO: serializable_hash method is not working well enough. Find a better
  # option to DRY up these specs
  def events_json(events)
    events.map do |event|
      {
        id: event.id,
        name: event.name,
        image_url: event.image_url,
        start_at: event.start_at
      }
    end.to_json
  end
end
