FactoryBot.define do
  factory :user do
    name { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { '123456' }
  end
end
