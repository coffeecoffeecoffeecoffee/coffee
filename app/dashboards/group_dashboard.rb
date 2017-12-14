require 'administrate/base_dashboard'

class GroupDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    events: Field::HasMany,
    id: Field::String.with_options(searchable: false),
    name: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    id
    name
    created_at
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    name
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = [
    :name
  ].freeze

  def display_resource(group)
    group.name
  end
end
