FactoryBot.define do
  factory :like do

    trait :valid_like do
      association :post, factory: [:post, :valid_post]
      association :user, factory: [:user, :valid_user]
    end

    trait :invalid_like do
    end
  end
end