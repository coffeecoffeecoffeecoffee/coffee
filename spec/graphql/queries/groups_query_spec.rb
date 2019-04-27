require "rails_helper"

RSpec.describe Queries::GroupsQuery, type: :graphql do
  let(:query) do
    <<~QUERY
      query($groupId: ID) {
        groups(id: $groupId) {
          id
          name
          events {
            id
            name
            startAt
            endAt
          }
        }
      }
    QUERY
  end

  context "without arguments" do
    it "returns all groups" do
      groups = create_list(:group, 2)
      events = create_list(:event, 2, group: groups.first)

      result = CoffeeSchema.execute(query).deep_symbolize_keys

      expect(result).to eq(
        data: {
          groups: groups.map { |g| group_item(g) }
        }
      )
    end
  end

  context "with an id argument" do
    it "returns the specified group" do
      groups = create_list(:group, 2)

      variables = {
        groupId: groups.first.id
      }

      result = CoffeeSchema.execute(
        query,
        variables: variables
      ).deep_symbolize_keys

      expect(result).to eq(
        data: {
          groups: [group_item(groups.first)]
        }
      )
    end
  end

  def group_item(group)
    {
      id: group.id,
      name: group.name,
      events: group.events.map { |e| event_item(e) }
    }
  end

  def event_item(event)
    {
      id: event.id,
      name: event.name,
      startAt: event.start_at.iso8601,
      endAt: event.end_at.iso8601
    }
  end
end
