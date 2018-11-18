class Provider < ApplicationRecord
  has_many :beneficiaries
  has_many :shoppings
  belongs_to :user
  belongs_to :city, optional: true

  scope :alive, -> { where(deleted: false) }
  scope :deleted, -> { where(deleted: true) }

  def soft_delete!
    update(deleted: true)
    user.soft_delete! unless user.deleted?
  end

  def beneficiaries_count
    beneficiaries.count
  end

  def shoppings_count
    beneficiaries.joins(:shoppings).count
  end
end
