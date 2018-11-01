class Beneficiary < ApplicationRecord
  belongs_to :provider
  belongs_to :city
  has_many :shoppings
  enum gender: [ :female, :male ]
  enum frequency: [ :weekly, :half_monthly, :monthly ]

  scope :active, -> { where(is_active: true) }

  def self.ordered
    order(is_active: :asc)
  end

  def make_active!
    update_columns(is_active: true)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def current_shop_count
    shoppings.count
  end

  def family_size
    family_components_count_0_1 + family_components_count_2_5 + family_components_count_6_12 + family_components_count_13_18 + family_components_count_19_30 + family_components_count_30_65 + family_components_count_over_65
  end
end
