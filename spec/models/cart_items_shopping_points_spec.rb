require 'rails_helper'

RSpec.describe CartItemsShoppingPoints do
  describe 'call' do
    context 'with an empty hash' do
      subject { CartItemsShoppingPoints.call(items: {}) }
      it 'returns 0' do
        expect(subject).to be_success
        expect(subject.data).to eq(0)
      end
    end

    context 'with some items available' do
      before(:context) do
        [
          { id: 1, unitary_amount: 1.0, category: :a},
          { id: 2, unitary_amount: 3.0, category: :a},
          { id: 3, unitary_amount: 2.3, category: :b},
          { id: 4, unitary_amount: 1.5, category: :b},
          { id: 5, unitary_amount: 0.4, category: :a},
        ].each do |current|
          item_category = ItemCategory.find_or_create_by(
            name: current[:category]
          )
          create(
            :warehouse_item,
            unitary_amount: current[:unitary_amount],
            item_category: item_category,
          )
        end
      end

      let(:items_a) do
        {
          "1" => { "quantity" => 1 },
          "2" => { "quantity" => 1 },
          "3" => { "quantity" => 1 },
          "4" => { "quantity" => 1 },
          "5" => { "quantity" => 1 },
        }
      end
      subject(:result_a) { CartItemsShoppingPoints.call(items: items_a) }

      let(:items_b) do
        {
          "1" => { "quantity" => 1 },
          "5" => { "quantity" => 3 },
        }
      end
      subject(:result_b) { CartItemsShoppingPoints.call(items: items_b) }

      it 'calculates the right total' do
        expect(result_a).to be_success
        expect(result_a.data).to eq(8)
        expect(result_b).to be_success
        expect(result_b.data).to eq(2)
      end
    end
  end
end
