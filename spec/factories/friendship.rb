# frozen_string_literal: true

FactoryBot.define do
  factory :friendship do
    trait :confirmed do
      user_id { 1 }
      friend_id { Faker::Number.digit }
      confirmed { true }
    end

    trait :rejected do
      user_id { 1 }
      friend_id { Faker::Number.digit }
      confirmed { false }
    end

    trait :pending do
      user_id { 1 }
      friend_id { Faker::Number.digit }
    end

    trait :incomplete do
      user_id {}
      friend_id {}
    end
  end
end
