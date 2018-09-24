class Shopping < ApplicationRecord
  belongs_to :beneficiary
  belongs_to :provider
  has_many :items, class_name: :ShoppingItem

  accepts_nested_attributes_for :items
end
