FactoryBot.define do
  factory :repeating_ride do
    frequency { rand(1..4) }
    location { Faker::Address.full_address }
    time { '8:00 AM' }
    days { [1, 3, 5] }
    user { create :user }
  end
end
