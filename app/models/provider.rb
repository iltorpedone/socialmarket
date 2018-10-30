class Provider < ApplicationRecord
  has_many :beneficiaries
  has_many :shoppings
  belongs_to :user
  belongs_to :city, optional: true
end
