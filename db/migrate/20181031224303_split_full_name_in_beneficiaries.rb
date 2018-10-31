class SplitFullNameInBeneficiaries < ActiveRecord::Migration[5.2]
  def change
    remove_column :beneficiaries, :full_name, :string
    add_column :beneficiaries, :first_name, :string
    add_column :beneficiaries, :last_name, :string
  end
end
