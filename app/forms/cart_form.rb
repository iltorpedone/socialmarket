require 'json'

class CartForm
  attr_accessor :shopping_id, :user
  include ActiveModel::Model

  def shopping
    @shopping ||= Shopping.find(shopping_id)
  end

  def beneficiary
    shopping.beneficiary
  end

  def price
    shopping.items.map(&:price).sum
  end

  def quantity
    shopping.items.pluck(:quantity).sum
  end

  def items_count
    shopping.items.count
  end

  def json_state
    JSON.generate({ quantity: quantity, price: price })
  end
end
