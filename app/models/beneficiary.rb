class Beneficiary < ApplicationRecord
  belongs_to :provider
  belongs_to :city
  has_many :shoppings
  enum gender: [ :female, :male ]
  enum frequency: [ :weekly, :half_monthly, :monthly ]

  scope :active, -> { where(is_active: true) }

  def self.ordered
    order(is_active: :asc, last_name: :asc)
  end

  def make_active!
    update_columns(is_active: true)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def full_name_by_last_name
    "#{last_name} #{first_name}"
  end

  def current_shop_count
    shoppings.count
  end

  def can_shop?
    max_shop_count > current_shop_count
  end

  def family_size
    family_components_count_0_1 + family_components_count_2_5 + family_components_count_6_12 + family_components_count_13_18 + family_components_count_19_30 + family_components_count_30_65 + family_components_count_over_65
  end

  # T
  def assigned_shopping_points
    point_rank * max_shop_count
  end

  def set_shopping_points
    self.shopping_points = assigned_shopping_points
  end

  # P
  def point_rank
    case family_size
    when 0 then 0
    when 1 then 80
    when 2 then 100
    when 3 then 110
    when 4 then 130
    when 5 then 140
    else
      140
    end
  end
end
