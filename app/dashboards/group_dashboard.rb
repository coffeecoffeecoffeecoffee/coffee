require 'administrate/base_dashboard'

class GroupDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    events: Field::HasMany,
    id: Field::String.with_options(searchable: false),
    name: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    time_zone: Field::String
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    name
    time_zone
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    name
    time_zone
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    name
    time_zone
  ].freeze

  def display_resource(group)
    group.name
  end
end
