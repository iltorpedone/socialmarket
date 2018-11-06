require "administrate/base_dashboard"

class WarehouseItemDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    item_category: Field::BelongsTo.with_options(order: 'name'),
    id: Field::Number,
    name: Field::String,
    unitary_amount: Field::String.with_options(searchable: false),
    stock_count: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :item_category,
    :id,
    :name,
    :stock_count,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :item_category,
    :id,
    :name,
    :unitary_amount,
    :stock_count,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :item_category,
    :name,
    :unitary_amount,
    :stock_count,
  ].freeze

  # Overwrite this method to customize how warehouse items are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(warehouse_item)
    warehouse_item.name
  end
end
