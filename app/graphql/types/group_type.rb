module Types
  class GroupType < GraphQL::Schema::Object
    field :id, ID, null: false
    field :name, String, null: false
    field :image_url, String, null: true
    field :events, [EventType], null: false
  end
end
