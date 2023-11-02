FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    username { Faker::Internet.username(specifier: 8) }
    password { "12345678"}
    confirmed_at { Time.now }
  end
end
