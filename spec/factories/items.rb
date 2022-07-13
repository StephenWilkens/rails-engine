FactoryBot.define do
  factory :item do
    name { Faker::Vehicle.model(make_of_model: 'Toyota') }
    description { Faker::Vehicle.style }
    unit_price { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    association :merchant
  end
end
