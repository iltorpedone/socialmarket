class AddShoppingPointsToBeneficiaries < ActiveRecord::Migration[5.2]
  def change
    add_column :beneficiaries, :shopping_points, :integer
  end
end
