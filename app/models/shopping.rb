class Shopping < ApplicationRecord
  belongs_to :beneficiary
  belongs_to :provider
  has_many :items, class_name: :ShoppingItem, dependent: :destroy
  enum status: [ :opened, :soft_closed, :hard_closed ]

  accepts_nested_attributes_for :items

  def update_total!
    update(total: items.map(&:price).sum)
  end

  def self.for_user(user)
    return all if user.administrator?

    return hard_closed if user.shop?

    return where(provider_id: user.provider.id) if user.provider?

    none
  end

  def self.ordered
    order(status: :asc, created_at: :desc)
  end
end
