class WarehouseItem < ApplicationRecord
  belongs_to :item_category
  has_many :shopping_items
end
