class CreateWarehouseItems < ActiveRecord::Migration[5.2]
  def change
    create_table :warehouse_items do |t|
      t.string :code
      t.text :description
      t.integer :item_category_id
      t.decimal :price
      t.integer :stock_count

      t.timestamps
    end
    add_index :warehouse_items, :code
    add_index :warehouse_items, :item_category_id
  end
end
