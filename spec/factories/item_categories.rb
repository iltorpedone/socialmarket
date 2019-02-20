FactoryBot.define do
  factory :item_category do
    sequence(:name) { |n| "item_category_#{n}" }
  end
end
