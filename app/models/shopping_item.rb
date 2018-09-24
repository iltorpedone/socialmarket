class ShoppingItem < ApplicationRecord
  belongs_to :shopping
  belongs_to :warehouse_item
end
