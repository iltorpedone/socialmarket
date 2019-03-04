class Shopping < ApplicationRecord
  belongs_to :beneficiary
  belongs_to :provider
  has_many :items, class_name: :ShoppingItem, dependent: :destroy
  enum status: [ :opened, :soft_closed, :hard_closed ]

  scope :query,  ->(q) {
    query_beneficiary(q).or(Shopping.query_provider(q))
  }
  scope :query_beneficiary, ->(q) {
    joins(:beneficiary, :provider).where("lower(beneficiaries.first_name) LIKE ? OR lower(beneficiaries.last_name) LIKE ?", "%#{q}%", "%#{q}%")
  }

  scope :query_provider, ->(q) {
    joins(:beneficiary, :provider).where("lower(providers.name) LIKE ?", "%#{q}%")
  }

  accepts_nested_attributes_for :items

  def update_total!
    update(total: items.map(&:price).sum)
  end

  def self.for_user(user)
    return all if user.administrator? || user.shop?

    return where(provider_id: user.provider.id) if user.provider?

    none
  end

  def self.ordered
    order(status: :asc, created_at: :desc)
  end

  def self.order_by(scope:, field:, direction: 'ASC')
    case field
    when 'beneficiary_name'
      scope.joins(:beneficiary).order([
        "beneficiaries.last_name #{direction}",
        "beneficiaries.first_name #{direction}",
        "shoppings.status ASC",
        "shoppings.created_at ASC",
      ].join(', '))
    when 'provider'
      scope.joins(:provider).order([
        "providers.name #{direction}",
        "shoppings.status ASC",
        "shoppings.created_at ASC",
      ])
    else
      scope.order("shoppings.#{field} #{direction}")
    end
  end

  def beneficiary_name
    beneficiary.full_name_by_last_name
  end
end
