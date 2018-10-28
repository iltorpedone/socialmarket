class AddIsActiveToBeneficiaries < ActiveRecord::Migration[5.2]
  def change
    add_column :beneficiaries, :is_active, :boolean, default: false
    add_index :beneficiaries, :is_active
  end
end
