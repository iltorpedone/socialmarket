class RemoveCurrentShopCountFromBeneficiaries < ActiveRecord::Migration[5.2]
  def change
    remove_column :beneficiaries, :current_shop_count, :integer
  end
end
