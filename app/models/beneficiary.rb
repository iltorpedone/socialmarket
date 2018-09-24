class Beneficiary < ApplicationRecord
  belongs_to :provider
  belongs_to :city
  has_many :shoppings
end
