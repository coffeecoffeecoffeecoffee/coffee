require 'administrate/base_dashboard'

class VenueDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    events: Field::HasMany,
    id: Field::String.with_options(searchable: false),
    foursquare_id: Field::String,
    name: Field::String,
    foursquare_url: Field::String,
    image_url: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    id
    foursquare_id
    name
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    foursquare_id
    name
    foursquare_url
    image_url
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = [
    :foursquare_id
  ].freeze

  def display_resource(venue)
    "#{venue.foursquare_id} - #{venue.name} - #{(Time.current - venue.created_at).to_i} seconds ago"
  end
end
