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
      wi = WarehouseItem.find(warehouse_item_id)
      wi.update(stock_count: wi.stock_count - quantity)
    end
    shopping.update_total!
  end

  def shopping
    @shopping ||= Shopping.find(shopping_id)
  end

  def beneficiary
    shopping.beneficiary
  end

  def price
    if shopping.hard_closed?
      deserialized_data['price']
    else
      presenter.price
    end
  end

  def shopping_items
    if shopping.hard_closed?
      deserialized_data['items'].map do |item|
        SerializedShoppingItem.new(
          item['category_name'],
          item['name'],
          item['quantity'],
          item['price'],
        )
      end
    else
      presenter.items
    end
  end

  def quantity
    if shopping.hard_closed?
      deserialized_data['quantity']
    else
      presenter.quantity
    end
  end

  def items_count
    if shopping.hard_closed?
      deserialized_data['items_count']
    else
      presenter.items_count
    end
  end

  def json_state
    JSON.generate({ quantity: quantity, price: price })
  end

  private
  def deserialized_data
    @deserialized_data ||= JSON.parse(shopping.serialized_data)
  end

  def presenter
    @presenter ||= ShoppingPresenter.new(shopping)
  end
end
