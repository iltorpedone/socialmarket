class RemoveFamilySizeFromBeneficiaries < ActiveRecord::Migration[5.2]
  def change
    remove_column :beneficiaries, :family_size, :integer
  end
end
