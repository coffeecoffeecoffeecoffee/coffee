require "rails_helper"

RSpec.describe "Groups", type: :request do
  describe "GET /groups" do
    it "returns a list of groups" do
      create_list(:group, 2)

      get api_groups_url

      expect(response).to match_openapi_spec("/groups", "get")
      expect(response).to have_json_size(2)
    end
  end
end
