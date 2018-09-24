class CreateShoppingItems < ActiveRecord::Migration[5.2]
  def change
    create_table :shopping_items do |t|
      t.integer :shopping_id
      t.integer :warehouse_item_id
      t.integer :quantity

      t.timestamps
    end
    add_index :shopping_items, :shopping_id
    add_index :shopping_items, :warehouse_item_id
  end
end
