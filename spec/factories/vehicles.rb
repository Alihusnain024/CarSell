FactoryBot.define do
 
  factory :vehicle do
    city {"lahore"}
    carModel {"suzuki"}
    engineType {"petrol"}
    color {"black"}
    assemblyType {"local"}
    mileage {20}
    price {5000000}
    description {"test"}
    transmissonType {"test"}
    engineCapicity {"test"}
    primaryContact {"03445381776"}
    secondaryContact {"03445381776"}
    user { create(:user) }

   end
end
