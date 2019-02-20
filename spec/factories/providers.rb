FactoryBot.define do
  factory :provider do
    sequence(:name) { |n| "provider_#{n}" }
    user
  end
end
