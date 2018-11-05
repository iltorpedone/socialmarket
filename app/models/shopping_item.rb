class ShoppingItem < ApplicationRecord
  belongs_to :shopping
  belongs_to :warehouse_item

  def price
    quantity * warehouse_item.unitary_amount
  end

  def category_name
    warehouse_item.category.name
  end
end
