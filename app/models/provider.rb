class Provider < ApplicationRecord
  has_many :beneficiaries
  has_many :shoppings
end
