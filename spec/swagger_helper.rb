# frozen_string_literal: true

require "rails_helper"
require "rake"

RSpec.configure do |config| # rubocop:disable Metrics/BlockLength
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join("swagger").to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    "v1/swagger.yaml" => {
      openapi: "3.0.1",
      info: {
        title: "Coffee",
        version: "v1"
      },
      servers: [
        # rswag is not compatible with having a base path in these server URLs.
        # In the future, we should be able to put `/api` in this file and remove
        # it from the `path` part of every request spec.
        # https://github.com/rswag/rswag/issues/318
        { url: "http://localhost:3000" },
        { url: "https://coffeecoffeecoffee.coffee" }
      ],
      components: {
        schemas: {
          event: {
            type: :object,
            properties: {
              id: { type: :string },
              group_id: { type: :string, nullable: true },
              name: { type: :string },
              image_url: { type: :string, nullable: true },
              start_at: { type: :string, format: :"date-time" },
              end_at: { type: :string, format: :"date-time" },
              venue: { oneOf: [{ "$ref": "#/components/schemas/venue" }, { type: :null }], nullable: true },
              is_online: { type: :boolean },
              online_event_url: { type: :string, nullable: true }
            },
            required: %i[id group_id name image_url start_at end_at venue is_online online_event_url],
            additionalProperties: false
          },
          group: {
            type: :object,
            properties: {
              id: { type: :string },
              name: { type: :string }
            },
            required: %i[id name],
            additionalProperties: false
          },
          location: {
            description: "http://microformats.org/wiki/adr",
            type: :object,
            properties: {
              address: { type: :string },
              extended_address: { type: :string },
              locality: { type: :string, description: "city or village" },
              region: { type: :string, description: "state or province" },
              postal_code: { type: :string, description: "e.g. US ZIP" },
              country: { type: :string },
              latitude: { type: :number },
              longitude: { type: :number }
            },
            additionalProperties: false
          },
          venue: {
            type: :object,
            properties: {
              name: { type: :string },
              location: { "$ref": "#/components/schemas/location" }
            },
            required: %i[name location],
            additionalProperties: false
          }
        }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end
