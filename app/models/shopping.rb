class Shopping < ApplicationRecord
  belongs_to :beneficiary
  belongs_to :provider
  has_many :items, class_name: :ShoppingItem
  enum status: [ :opened, :soft_closed, :hard_closed ]

  accepts_nested_attributes_for :items

  def update_total!
    update(total: items.map(&:price).sum)
  end

  def self.for_user(user)
    return all if user.administrator?
    if user.provider?
      return where(provider_id: user.provider.id)
    end
    none
  end

  def self.ordered
    order(status: :asc, created_at: :desc)
  end
end
