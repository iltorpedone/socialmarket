class ChangeFrequencyFromBeneficiaries < ActiveRecord::Migration[5.2]
  def change
    change_column_default :beneficiaries, :frequency, 0
  end
end
