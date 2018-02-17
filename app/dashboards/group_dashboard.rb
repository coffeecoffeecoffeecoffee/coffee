require 'administrate/base_dashboard'

class GroupDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    events: Field::HasMany,
    id: Field::String.with_options(searchable: false),
    name: Field::String,
    created_at: Field::DateTime.with_options(timezone: 'America/Los_Angeles'),
    updated_at: Field::DateTime.with_options(timezone: 'America/Los_Angeles'),
    emoji: Field::String,
    time_zone: Field::String
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    name
    emoji
    time_zone
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    name
    emoji
    time_zone
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    name
    emoji
    time_zone
  ].freeze

  def display_resource(group)
    group.name
  end
end
