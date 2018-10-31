class RemoveContributionFromBeneficiaries < ActiveRecord::Migration[5.2]
  def change
    remove_column :beneficiaries, :contribution, :decimal
  end
end
