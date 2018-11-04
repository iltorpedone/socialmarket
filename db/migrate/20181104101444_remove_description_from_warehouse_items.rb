class RemoveDescriptionFromWarehouseItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :warehouse_items, :description, :text
  end
end
