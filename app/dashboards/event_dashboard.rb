require 'administrate/base_dashboard'

class EventDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::String.with_options(searchable: false),
    start_at: Field::DateTime,
    end_at: Field::DateTime,
    location: Field::String,
    location_url: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    id
    start_at
    end_at
    location
    location_url
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    start_at
    end_at
    location
    location_url
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    start_at
    end_at
    location
    location_url
  ].freeze
end
