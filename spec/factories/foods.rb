FactoryBot.define do
  factory :food do
    name { Faker::Food.dish }
    description { "tes" }
    price { 10000.0 }
    categories { build_list(:category, 2) }
  end

  factory :invalid_food, parent: :food do
    name { nil }
    description { nil }
    price { nil }
  end
end
