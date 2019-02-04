class AddBirthdateToBeneficiaries < ActiveRecord::Migration[5.2]
  def change
    add_column :beneficiaries, :birthdate, :date
  end
end
