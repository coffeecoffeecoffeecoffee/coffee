require "administrate/base_dashboard"

class EventDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::String.with_options(searchable: false),
    start_at: Field::DateTime,
    end_at: Field::DateTime,
    name: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    group: Field::BelongsTo,
    foursquare_venue_id: Field::String,
    online_venue_url: Field::String,
    image: Field::ActiveStorage,
    host: Field::BelongsTo.with_options(class_name: "User")
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    group
    name
    start_at
    end_at
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    group
    host
    start_at
    end_at
    name
    foursquare_venue_id
    online_venue_url
    image
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    group
    host
    start_at
    end_at
    name
    foursquare_venue_id
    online_venue_url
    image
  ].freeze
end
