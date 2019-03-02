class WarehouseItem < ApplicationRecord
  belongs_to :item_category
  has_many :shopping_items

  scope :alive, -> { where(deleted: false) }
  scope :deleted, -> { where(deleted: true) }

  def self.ordered
    includes(:item_category).
      order('item_categories.name ASC, warehouse_items.name ASC')
  end

  def soft_delete!
    update_columns(deleted: true)
  end
end
