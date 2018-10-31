class AddFamilyFieldsToBeneficiaries < ActiveRecord::Migration[5.2]
  def change
    add_column :beneficiaries, :family_components_count_0_1, :integer
    add_column :beneficiaries, :family_components_count_2_5, :integer
    add_column :beneficiaries, :family_components_count_6_12, :integer
    add_column :beneficiaries, :family_components_count_13_18, :integer
    add_column :beneficiaries, :family_components_count_19_30, :integer
    add_column :beneficiaries, :family_components_count_30_65, :integer
    add_column :beneficiaries, :family_components_count_over_65, :integer
  end
end
