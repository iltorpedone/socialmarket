class AddMaxPurchasableCountToWarehouseItems < ActiveRecord::Migration[5.2]
  def change
    add_column :warehouse_items, :max_purchasable_count, :integer
  end
end
