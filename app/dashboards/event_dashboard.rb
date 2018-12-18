require "administrate/base_dashboard"

class EventDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::String.with_options(searchable: false),
    start_at: Field::DateTime,
    end_at: Field::DateTime,
    location: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    group: Field::BelongsTo,
    venue: Field::BelongsTo,
    foursquare_venue_id: Field::String
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    group
    location
    venue
    start_at
    end_at
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    group
    start_at
    end_at
    location
    venue
    foursquare_venue_id
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    group
    start_at
    end_at
    location
    venue
    foursquare_venue_id
  ].freeze
end
