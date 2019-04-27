module Queries
  module GroupsQuery
    extend ActiveSupport::Concern

    included do
      field :groups, [Types::GroupType], null: false do
        argument :id, "ID", required: false
      end
    end

    def groups(id: nil)
      return Group.all unless id

      [Group.friendly.find(id)]
    end
  end
end
