FactoryBot.define do
  factory :warehouse_item do
    sequence(:name) { |n| "item_#{n}" }
    item_category
    sequence(:id) { |n| n }
    unitary_amount { 1.0 }
    stock_count { 1 }
  end
end
