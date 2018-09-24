class CreateBeneficiaries < ActiveRecord::Migration[5.2]
  def change
    create_table :beneficiaries do |t|
      t.string :full_name
      t.string :address
      t.integer :city_id
      t.string :telephone
      t.integer :family_size
      t.integer :children_count
      t.integer :max_shop_count
      t.integer :current_shop_count
      t.integer :frequency
      t.integer :provider_id
      t.datetime :extended_at
      t.decimal :contribution

      t.timestamps
    end
    add_index :beneficiaries, :city_id
    add_index :beneficiaries, :frequency
    add_index :beneficiaries, :provider_id
  end
end
