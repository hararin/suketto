FactoryBot.define do
  factory :user do

  	factory :user1 do
  		name { "testuser1" }
  		email { Faker::Internet.free_email }
  		password { "password1" }
  		age { 20 }
  		ticket { 20 }
  		is_banned { false }
  		is_deleted { false }
  		trait :banned_user do
  			is_banned { true }
  		end
  		trait :deleted_user do
  			is_deleted { true }
  		end
  		after(:create) do |user|
  			create :request, user: user
  		end
  	end

  	factory :user2 do
  		name { "testuser2" }
  		email { Faker::Internet.free_email }
  		password { "password2" }
  		age { 20 }
  		ticket { 30 }
  		is_banned { false }
  		is_deleted { false }
      after(:create) do |user|
        create :participant, user: user
      end
  	end

    factory :user3 do
      name { "testuser3" }
      email { Faker::Internet.free_email }
      password { "password3" }
      age { 20 }
      ticket { 30 }
      is_banned { false }
      is_deleted { false }
    end
  end
end