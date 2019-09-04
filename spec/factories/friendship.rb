# frozen_string_literal: true

FactoryBot.define do
  factory :friendship do
    user1 = Factory.build(:user)
    user2 = Factory.build(:user)
    user3 = Factory.build(:user)
    user4 = Factory.build(:user)

    trait :confirmed do
      user_id { user1.id }
      friend_id { user2.id }
      confirmed { true }
    end

    trait :rejected do
      user_id { user1.id }
      friend_id { user3.id }
      confirmed { false }
    end

    trait :pending do
      user_id { user1.id }
      friend_id { user4.id }
    end
  end
end
