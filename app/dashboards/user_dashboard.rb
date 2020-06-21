require "administrate/base_dashboard"

class UserDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    memberships: Field::HasMany,
    groups: Field::HasMany,
    id: Field::String.with_options(searchable: false),
    name: Field::String,
    email: Field::String,
    twitter: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  COLLECTION_ATTRIBUTES = %i[
    name
    twitter
    email
  ].freeze

  SHOW_PAGE_ATTRIBUTES = %i[
    id
    memberships
    groups
    name
    email
    twitter
    created_at
    updated_at
  ].freeze

  FORM_ATTRIBUTES = %i[
    memberships
    groups
    name
    email
    twitter
  ].freeze

  def display_resource(user)
    user.name
  end
end
