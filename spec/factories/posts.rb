FactoryBot.define do
  factory :post do

    trait :valid_post do
      id { 1 }
      content { "This is my new post" }
      association :author, :valid_user
    end

    trait :invalid_post do
      content { '' }
    end
  end
end
