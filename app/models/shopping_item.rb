class ShoppingItem < ApplicationRecord
  belongs_to :shopping
  belongs_to :warehouse_item

  def price
    quantity * warehouse_item.unitary_amount
  end

  def category_name
    warehouse_item.item_category.name
  end

  def name
    warehouse_item.name
  end
end
