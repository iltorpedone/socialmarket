class Provider < ApplicationRecord
  has_many :beneficiaries
  has_many :shoppings
  belongs_to :user
  belongs_to :city, optional: true

  scope :alive, -> { where(deleted: false) }
  scope :deleted, -> { where(deleted: true) }

  def soft_delete!
    update(deleted: true)
  end
end
