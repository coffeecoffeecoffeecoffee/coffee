require "rails_helper"

RSpec.describe Queries::GroupsQuery, type: :graphql do
  let(:query) do
    <<~QUERY
      query($groupId: ID) {
        groups(id: $groupId) {
          id
          slug
          name
          imageUrl
          events {
            id
            name
            imageUrl
            startAt
            endAt
            venue {
              name
              location {
                latitude
                longitude
              }
            }
          }
        }
      }
    QUERY
  end

  context "without arguments" do
    it "returns all groups" do
      groups = create_list(:group, 2)
      create_list(:event, 2, group: groups.first)

      result = CoffeeSchema.execute(query).deep_symbolize_keys

      expect(result).to eq(
        data: {
          groups: groups.map { |g| group_item(g) }
        }
      )
    end
  end

  context "with an id argument (either id or slug)" do
    it "returns the specified group" do
      groups = create_list(:group, 2)

      # ID

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

      # Slug

      variables = {
        groupId: groups.first.slug
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
      slug: group.slug,
      name: group.name,
      imageUrl: group.image_url,
      events: group.events.map { |e| event_item(e) }
    }
  end

  def event_item(event)
    {
      id: event.id,
      name: event.name,
      imageUrl: event.image_url,
      startAt: event.start_at.iso8601,
      endAt: event.end_at.iso8601,
      venue: venue_item(event.venue)
    }
  end

  def venue_item(venue)
    {
      name: venue.name,
      location: location_item(venue.latitude, venue.longitude)
    }
  end

  def location_item(latitude, longitude)
    {
      latitude: latitude,
      longitude: longitude
    }
  end
end
