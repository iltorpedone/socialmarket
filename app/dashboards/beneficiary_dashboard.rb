require "administrate/base_dashboard"

class BeneficiaryDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    provider: Field::BelongsTo.with_options(order: 'name'),
    city: Field::BelongsTo.with_options(order: 'name'),
    is_active: Field::Boolean,
    shoppings: Field::HasMany,
    id: Field::Number,
    first_name: Field::String,
    last_name: Field::String,
    birthdate: DateField.with_options(format: "%Y-%m-%d"),
    gender: EnumField.with_options(mapping: Beneficiary.genders),
    frequency: EnumField.with_options(mapping: Beneficiary.frequencies),
    family_components_count_0_1: Field::Select.with_options(collection: 0..15),
    family_components_count_2_5: Field::Select.with_options(collection: 0..15),
    family_components_count_6_12: Field::Select.with_options(collection: 0..15),
    family_components_count_13_18: Field::Select.with_options(collection: 0..15),
    family_components_count_19_30: Field::Select.with_options(collection: 0..15),
    family_components_count_30_65: Field::Select.with_options(collection: 0..15),
    family_components_count_over_65: Field::Select.with_options(collection: 0..15),
    family_size: Field::Number,
    address: Field::String,
    telephone: Field::String,
    children_count: Field::Number,
    proposed_max_shop_count: Field::Number,
    max_shop_count: Field::Number,
    current_shop_count: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :provider,
    :city,
    :first_name,
    :last_name,
    :birthdate,
    :max_shop_count,
    :current_shop_count,
    :frequency,
    :is_active,
    :id,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :provider,
    :city,
    :is_active,
    :id,
    :first_name,
    :last_name,
    :birthdate,
    :gender,
    :address,
    :telephone,
    :family_size,
    :family_components_count_0_1,
    :family_components_count_2_5,
    :family_components_count_6_12,
    :family_components_count_13_18,
    :family_components_count_19_30,
    :family_components_count_30_65,
    :family_components_count_over_65,
    :children_count,
    :proposed_max_shop_count,
    :max_shop_count,
    :current_shop_count,
    :frequency,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :provider,
    :city,
    :first_name,
    :last_name,
    :birthdate,
    :gender,
    :is_active,
    :address,
    :telephone,
    :family_components_count_0_1,
    :family_components_count_2_5,
    :family_components_count_6_12,
    :family_components_count_13_18,
    :family_components_count_19_30,
    :family_components_count_30_65,
    :family_components_count_over_65,
    :children_count,
    :proposed_max_shop_count,
    :max_shop_count,
    :frequency,
  ].freeze

  # Overwrite this method to customize how beneficiaries are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(beneficiary)
    "#{beneficiary.full_name} [##{beneficiary.id}]"
  end
end
