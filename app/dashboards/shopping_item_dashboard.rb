require "administrate/base_dashboard"

class ShoppingItemDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    shopping: Field::BelongsTo.with_options(order: 'created_at'),
    warehouse_item: Field::BelongsTo.with_options(order: 'name'),
    id: Field::Number,
    quantity: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    # :shopping,
    :warehouse_item,
    :id,
    :quantity,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :shopping,
    :warehouse_item,
    :id,
    :quantity,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :shopping,
    :warehouse_item,
    :quantity,
  ].freeze

  # Overwrite this method to customize how shopping items are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(shopping_item)
    "[#{shopping_item.category_name}>#{shopping_item.name}] x#{shopping_item.quantity} = #{shopping_item.price} [##{shopping_item.id}]"
  end
end
