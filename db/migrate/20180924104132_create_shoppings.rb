class CreateShoppings < ActiveRecord::Migration[5.2]
  def change
    create_table :shoppings do |t|
      t.string :code
      t.integer :beneficiary_id
      t.integer :provider_id
      t.decimal :total
      t.text :items

      t.timestamps
    end
    add_index :shoppings, :code
    add_index :shoppings, :beneficiary_id
    add_index :shoppings, :provider_id
  end
end
