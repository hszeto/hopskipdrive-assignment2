FactoryBot.define do
  factory :ride do
    day { 1 }
    time { "MyString" }
    location { "MyString" }
    repeating_ride { nil }
  end
end
