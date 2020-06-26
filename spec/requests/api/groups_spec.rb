require "swagger_helper"

RSpec.describe "Groups API", type: :request do
  path "/api/groups" do
    get "List public groups" do
      response "200", "OK" do
        produces "application/json"
        schema type: :array, items: { "$ref": "#/components/schemas/group" }

        before { create_list(:group, 2) }

        run_test! do |response|
          expect(response.body).to have_json_size(2)
        end
      end
    end
  end
end
