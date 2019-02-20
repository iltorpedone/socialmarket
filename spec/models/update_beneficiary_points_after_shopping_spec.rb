require 'rails_helper'

RSpec.describe UpdateBeneficiaryPointsAfterShopping do
  describe '.call' do
    context 'with a beneficiary with 50 points' do
      let!(:beneficiary) { create(:beneficiary, shopping_points: 50) }

      context 'with a shopping with a total of 10 points' do
        let!(:shopping) do
          create(:shopping, total: 10, beneficiary: beneficiary)
        end

        subject do
          UpdateBeneficiaryPointsAfterShopping.call(shopping: shopping)
        end

        it 'updates the beneficiary shopping points to 40' do
          expect(subject).to be_success
          beneficiary.reload
          expect(beneficiary.shopping_points).to eq(40)
        end
      end
    end
  end
end
