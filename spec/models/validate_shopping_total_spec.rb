require 'rails_helper'

RSpec.describe ValidateShoppingTotal do
  describe '.call' do
    # This is an arbitrary value, should be anything >= 0.
    let(:point_rank) { 13 }

    it 'validates all values within (p..p+3)' do
      ((point_rank)..(point_rank + 3)).each do |total|
        result = ValidateShoppingTotal.call(
          total: total,
          point_rank: point_rank,
        )
        expect(result).to be_success
      end
    end

    it 'does not validate values that are outside (p-10..p)' do
      [point_rank - 1, point_rank + 4].each do |total|
        result = ValidateShoppingTotal.call(
          total: total,
          point_rank: point_rank,
        )
        expect(result).to be_error
      end
    end
  end
end
