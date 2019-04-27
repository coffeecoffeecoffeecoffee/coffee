module Types
  class EventType < GraphQL::Schema::Object
    field :id, ID, null: false
    field :name, String, null: false
    field :start_at, String, null: false
    field :end_at, String, null: false
  end
end
