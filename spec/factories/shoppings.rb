FactoryBot.define do
  factory :shopping do
    total { 10.0 }
    status { :opened }

    beneficiary
    provider
    trait :opened do
      status { :opened }
    end
    trait :soft_closed do
      status { :soft_closed }
    end
    trait :hard_closed do
      status { :hard_closed }
    end
  end
end
