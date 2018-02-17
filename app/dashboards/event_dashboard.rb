require 'administrate/base_dashboard'

class EventDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::String.with_options(searchable: false),
    start_at: Field::DateTime.with_options(timezone: 'America/Los_Angeles'),
    end_at: Field::DateTime.with_options(timezone: 'America/Los_Angeles'),
    location: Field::String,
    created_at: Field::DateTime.with_options(timezone: 'America/Los_Angeles'),
    updated_at: Field::DateTime.with_options(timezone: 'America/Los_Angeles'),
    group: Field::BelongsTo,
    venue_foursquare_id: Field::String
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
    venue_foursquare_id
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    group
    start_at
    end_at
    location
    venue_foursquare_id
  ].freeze
end
