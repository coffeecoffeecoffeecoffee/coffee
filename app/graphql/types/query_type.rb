module Types
  class QueryType < GraphQL::Schema::Object
    include Queries::GroupsQuery
  end
end
