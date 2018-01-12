require 'administrate/base_dashboard'

class EventDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::String.with_options(searchable: false),
    start_at: EventTimeField,
    end_at: EventTimeField,
    location: Field::String,
    location_url: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    group: Field::BelongsTo
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    group
    start_at
    end_at
    location
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    group
    start_at
    end_at
    location
    location_url
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    group
    start_at
    end_at
    location
    location_url
  ].freeze
end
