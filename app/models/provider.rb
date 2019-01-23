class Provider < ApplicationRecord
  has_many :beneficiaries
  has_many :shoppings
  belongs_to :user
  belongs_to :city, optional: true

  scope :alive, -> { where(deleted: false) }
  scope :deleted, -> { where(deleted: true) }

  def soft_delete!
    result = update(deleted: true)
    return result unless result

    unless user.deleted?
      result = user.soft_delete!
      return result unless result
    end
    true
  end

  def beneficiaries_count
    beneficiaries.count
  end

  def shoppings_count
    beneficiaries.joins(:shoppings).count
  end
end
