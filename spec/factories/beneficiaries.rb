FactoryBot.define do
  factory :beneficiary do
    shopping_points { 50 }
    provider
    city
    family_components_count_2_5 { 0 }
    family_components_count_6_12 { 0 }
    family_components_count_13_18 { 0 }
    family_components_count_19_30 { 0 }
    family_components_count_30_65 { 0 }
    family_components_count_over_65 { 0 }
  end
end
