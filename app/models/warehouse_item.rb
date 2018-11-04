class WarehouseItem < ApplicationRecord
  belongs_to :item_category
  has_many :shopping_items

  def self.ordered
    includes(:item_category).order('item_categories.name ASC')
  end
end
