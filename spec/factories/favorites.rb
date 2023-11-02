FactoryBot.define do
  factory :favorite do
    association :user
    association :vehicle
  end
end
