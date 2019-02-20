FactoryBot.define do
  factory :user do
    sequence(:full_name) { |n| "Minion_#{n}" }
    sequence(:email) { |n| "minion#{n}@users.org" }

    password { 'S3cret!' }
    is_active { true }
    deleted { false }

    # app_role
    trait :administrator do
      app_role { :administrator }
    end
    trait :provider do
      app_role { :provider }
    end
    trait :shop do
      app_role { :shop }
    end
    trait :warehouse_worker do
      app_role { :warehouse_worker }
    end
  end
end
