class AddDeletedToWarehouseItems < ActiveRecord::Migration[5.2]
  def change
    add_column :warehouse_items, :deleted, :boolean, default: false
    add_index :warehouse_items, :deleted
  end
end
