require "swagger_helper"

RSpec.describe "Events API", type: :request do
  path "/api/groups/{group_id}/events" do
    get "List of events for the specified group in descending order" do
      response "200", "OK" do
        consumes "application/json"
        parameter name: :group_id, in: :path, type: :string

        produces "application/json"
        schema type: :array, items: { "$ref": "#/components/schemas/event" }

        let(:group) { create(:group) }
        let(:group_id) { group.id }

        let!(:future_event) { create(:future_event, group: group) }
        let!(:now_event) { create(:now_event, group: group) }
        let!(:past_event) { create(:past_event, group: group) }
        let!(:really_future_event) { create(:really_future_event, group: group) }

        before { create(:event) } # other event

        run_test! do |response|
          event_ids = JSON(response.body).map { |e| e["id"] }
          expect(event_ids).to eq([
                                    really_future_event.id,
                                    future_event.id,
                                    now_event.id,
                                    past_event.id
                                  ])
        end
      end
    end
  end
end
