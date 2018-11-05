require 'json'

class CartForm
  attr_accessor :shopping_id, :user
  include ActiveModel::Model

  def bulk_add(items)
    items.select do |warehouse_item_id, item|
      item['quantity'] > 0
    end.each do |warehouse_item_id, item|
      shopping.items.create!(
        warehouse_item_id: warehouse_item_id,
        quantity: item['quantity'],
      )
    end
  end

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
