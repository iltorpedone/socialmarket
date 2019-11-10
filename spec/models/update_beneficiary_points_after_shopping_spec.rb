require 'rails_helper'

RSpec.describe UpdateBeneficiaryPointsAfterShopping do
  describe '.call' do
    context 'with a beneficiary with 150 points and 80 point rank' do
      let!(:beneficiary) do
        create(
          :beneficiary,
          shopping_points: 150,
          family_components_count_0_1: 1, # point rank: 80
        )
      end

      subject do
        UpdateBeneficiaryPointsAfterShopping.call(beneficiary: beneficiary)
      end

      it 'updates the beneficiary shopping points to 70' do
        expect(subject).to be_success
        beneficiary.reload
        expect(beneficiary.shopping_points).to eq(70)
      end
    end
  end
end
