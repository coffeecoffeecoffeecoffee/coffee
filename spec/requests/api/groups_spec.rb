require "rails_helper"

RSpec.describe "Groups", type: :request do
  describe "GET /groups" do
    it "returns a list of active groups" do
      create(:inactive_event)
      create_list(:event, 2)

      get api_groups_url

      expect(response).to have_json_size(2)
    end
  end
end
