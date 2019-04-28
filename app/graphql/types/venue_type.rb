module Types
  class VenueType < GraphQL::Schema::Object
    field :name, String, null: false
    field :location, Types::LocationType, null: false

    def location
      {
        latitude: object.latitude,
        longitude: object.longitude
      }
    end
  end
end
