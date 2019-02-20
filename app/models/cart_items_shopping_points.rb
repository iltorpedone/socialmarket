class CartItemsShoppingPoints
  include Mu

  def self.call(items:)
    warehouse_items = WarehouseItem.find(items.keys)
    value = warehouse_items.reduce(0) do |sub_total, warehouse_item|
      item_key = warehouse_item.id.to_s
      sub_total += warehouse_item.unitary_amount * items[item_key]['quantity']
    end.to_i
    Result.success(value)
  end
end
