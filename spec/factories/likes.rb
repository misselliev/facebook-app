# frozen_string_literal: true

FactoryBot.define do
  factory :like do
    trait :valid_like do
      association :post, factory: %i[post valid_post]
      association :user, factory: %i[user valid_user]
    end

    trait :invalid_like do
    end
  end
end
