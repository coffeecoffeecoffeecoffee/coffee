require "administrate/base_dashboard"

class MembershipDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    group: Field::BelongsTo,
    id: Field::String.with_options(searchable: false),
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    group
    user
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    user
    group
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    user
    group
  ].freeze
end
