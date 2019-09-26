# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    trait :valid_comment do
      content { 'This is a comment' }
      association :post, factory: %i[post valid_post]
      association :commenter, factory: %i[user valid_user]
    end

    trait :invalid_comment do
      content { '' }
    end
  end
end
