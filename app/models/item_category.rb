class ItemCategory < ApplicationRecord
  has_many :warehouse_items

  def self.ordered
    order(name: :asc)
  end
end
