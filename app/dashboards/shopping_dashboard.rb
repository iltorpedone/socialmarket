require "administrate/base_dashboard"

class ShoppingDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    beneficiary: Field::BelongsTo.with_options(
      order: 'full_name',
      scope: -> { Beneficiary.active },
    ),
    provider: Field::BelongsTo.with_options(order: 'name'),
    id: Field::Number,
    code: Field::String,
    total: Field::String.with_options(searchable: false),
    items: Field::HasMany.with_options(class_name: 'ShoppingItem'),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :beneficiary,
    :provider,
    :id,
    :code,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :beneficiary,
    :provider,
    :id,
    :code,
    :total,
    :items,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :beneficiary,
    :provider,
    :code,
    # :total,
    # :items,
  ].freeze

  # Overwrite this method to customize how shoppings are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(shopping)
    "[##{shopping.id}] Beneficiario \"#{shopping.beneficiary.full_name}\""
  end
end
