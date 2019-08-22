FactoryBot.define do
  factory :comment do
   
    trait :valid_comment do
      content { "This is a comment" }
      association :post, factory: [:post, :valid_post]
      association :commenter, factory: [:user, :valid_user]
      # association :commenter, :valid_user
    end 

    trait :invalid_comment do
      content { '' }
    end
  end
end