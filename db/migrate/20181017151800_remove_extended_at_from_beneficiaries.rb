class RemoveExtendedAtFromBeneficiaries < ActiveRecord::Migration[5.2]
  def change
    remove_column :beneficiaries, :extended_at, :datetime
  end
end
