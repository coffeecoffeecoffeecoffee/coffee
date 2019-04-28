module Types
  class LocationType < GraphQL::Schema::Object
    field :latitude, Float, null: true
    field :longitude, Float, null: true
  end
end
