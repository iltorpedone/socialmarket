class AddGenderToBeneficiaries < ActiveRecord::Migration[5.2]
  def change
    add_column :beneficiaries, :gender, :integer, default: 0
    add_index :beneficiaries, :gender
  end
end
