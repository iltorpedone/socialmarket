require 'rails_helper'

RSpec.describe ValidateShoppingTotal do
  describe '.call' do
    # This is an arbitrary value, should be anything > 10.
    let(:point_rank) { 13 }

    it 'validates all values within (p-10..p+5)' do
      ((point_rank - 10)..(point_rank + 5)).each do |total|
        result = ValidateShoppingTotal.call(
          total: total,
          point_rank: point_rank,
        )
        expect(result).to be_success
      end
    end

    it 'does not validate values that are outside (p-10..p..5)' do
      ((point_rank - 20)..(point_rank - 11)).each do |total|
        result = ValidateShoppingTotal.call(
          total: total,
          point_rank: point_rank,
        )
        expect(result).to be_error
      end

      ((point_rank + 6)..(point_rank + 10)).each do |total|
        result = ValidateShoppingTotal.call(
          total: total,
          point_rank: point_rank,
        )
        expect(result).to be_error
      end
    end
  end
end
