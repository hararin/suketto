FactoryBot.define do
  factory :request do
    title { "testrequest1" }
    datetime { "2100-09-01 00:00:00" }
    address { "testaddress1" }
    capacity { 5 }
    deadline { "2100-08-30 00:00:00" }
    return_status { 0 }
    trait :request2 do
      return_status { 1 }
    end
    trait :request3 do
      datetime { "2017-09-01 00:00:00" }
    end
    association :user, factory: :user1
  end
end