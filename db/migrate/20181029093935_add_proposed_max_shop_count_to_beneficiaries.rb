class AddProposedMaxShopCountToBeneficiaries < ActiveRecord::Migration[5.2]
  def change
    add_column :beneficiaries, :proposed_max_shop_count, :integer
  end
end
