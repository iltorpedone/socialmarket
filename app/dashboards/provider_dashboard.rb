require "administrate/base_dashboard"

class ProviderDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    address: Field::String,
    beneficiaries: Field::HasMany,
    city: Field::BelongsTo.with_options(order: 'name'),
    created_at: Field::DateTime,
    email: Field::Email,
    id: Field::Number,
    name: Field::String,
    referent: Field::String,
    shoppings: Field::HasMany,
    beneficiaries_count: Field::Number,
    shoppings_count: Field::Number,
    telephone: Field::String,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :name,
    :city,
    :email,
    :telephone,
    :address,
    :referent,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :name,
    :city,
    :email,
    :telephone,
    :address,
    :beneficiaries_count,
    :shoppings_count,
    :referent,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :name,
    :city,
    :email,
    :telephone,
    :address,
    :referent,
  ].freeze

  # Overwrite this method to customize how providers are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(provider)
    provider.name
  end
end
