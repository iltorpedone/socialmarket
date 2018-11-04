class RenameFieldsInWarehouseItems < ActiveRecord::Migration[5.2]
  def change
    rename_column :warehouse_items, :price, :unitary_amount
    rename_column :warehouse_items, :code, :name
  end
end
