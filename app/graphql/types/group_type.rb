module Types
  class GroupType < GraphQL::Schema::Object
    field :id, ID, null: false
    field :name, String, null: false
    field :events, [EventType], null: false
  end
end
