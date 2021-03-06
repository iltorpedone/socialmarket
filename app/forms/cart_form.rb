require 'json'

class CartForm
  include Mu

  attr_accessor :shopping_id, :user
  include ActiveModel::Model

  def bulk_add(items)
    items.select do |warehouse_item_id, item|
      item['quantity'] > 0
    end.each do |warehouse_item_id, item|
      same_item = shopping.items.find_by(warehouse_item_id: warehouse_item_id)
      if same_item
        same_item.update(quantity: same_item.quantity + item['quantity'])
      else
        shopping.items.create!(
          warehouse_item_id: warehouse_item_id,
          quantity: item['quantity'],
        )
      end
      wi = WarehouseItem.find(warehouse_item_id)
      wi.update(stock_count: wi.stock_count - item['quantity'])
    end
    shopping.update_total!
    Result.success
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

  def point_rank
    beneficiary.point_rank
  end

  def point_range
    ValidateShoppingTotal.range(point_rank: point_rank)
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
