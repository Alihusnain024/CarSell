
FactoryBot.define do
  factory :vehicle do
    city { Faker::Address.city }
    mileage { Faker::Number.number(digits: 5) }
    carModel { Faker::Vehicle.make_and_model }
    price { Faker::Number.decimal(l_digits: 5, r_digits: 2) }
    engineType { Faker::Vehicle.engine }
    transmissionType { Faker::Vehicle.transmission }
    engineCapacity { Faker::Number.decimal(l_digits: 1, r_digits: 1) }
    color { Faker::Vehicle.color }
    assemblyType { Faker::Vehicle.style }
    description { Faker::Lorem.paragraph }
    primaryContact { Faker::PhoneNumber.phone_number }
    secondaryContact { Faker::PhoneNumber.cell_phone }
    status { 'active' }

    association :user, factory: :user 
  end
end
