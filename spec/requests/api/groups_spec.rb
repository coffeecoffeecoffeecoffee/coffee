require "rails_helper"

RSpec.describe "Groups", type: :request do
  describe "GET /groups" do
    it "returns a list of groups" do
      create_list(:group, 2)

      get groups_url(subdomain: :api)

      expect(response).to have_http_status(:ok)
      expect(response).to match_json_schema("groups")
    end
  end
end
