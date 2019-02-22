require "administrate/base_dashboard"

class ShoppingDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    beneficiary: ShoppingBeneficiaryField.with_options(
      order: 'last_name',
      scope: -> { Beneficiary.active.ordered },
    ),
    provider: Field::BelongsTo.with_options(order: 'name'),
    id: Field::Number,
    total: Field::String.with_options(searchable: false),
    items: Field::HasMany.with_options(class_name: 'ShoppingItem'),
    status: EnumField.with_options(mapping: Shopping.statuses),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :status,
    :beneficiary,
    :provider,
    :total,
    :id,
    :created_at,
    :updated_at,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :status,
    :beneficiary,
    :provider,
    :id,
    :total,
    # :items,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :beneficiary,
    :provider,
    :status,
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
