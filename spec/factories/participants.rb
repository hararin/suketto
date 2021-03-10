FactoryBot.define do
  factory :participant do
  	association :user, factory: :user2
  	request
  end
end