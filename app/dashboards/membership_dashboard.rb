require "administrate/base_dashboard"

class MembershipDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::String.with_options(searchable: false),
    group: Field::BelongsTo,
    user: Field::BelongsTo,
    admin: Field::Boolean,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    group
    user
    admin
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    group
    user
    admin
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    group
    user
    admin
  ].freeze
end
