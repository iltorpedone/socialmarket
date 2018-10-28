class Beneficiary < ApplicationRecord
  belongs_to :provider
  belongs_to :city
  has_many :shoppings

  scope :active, -> { where(is_active: true) }

  def self.ordered
    order(is_active: :asc)
  end

  def make_active!
    update_columns(is_active: true)
  end
end
