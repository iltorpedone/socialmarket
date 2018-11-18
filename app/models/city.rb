class City < ApplicationRecord
  has_many :beneficiaries

  def shoppings_count
    beneficiaries.joins(:shoppings).count
  end

  def beneficiaries_count
    beneficiaries.count
  end
end
