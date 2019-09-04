# frozen_string_literal: true

FactoryBot.define do
  factory :user, aliases: [:author] do
    trait :valid_user do
      id { 1 }
      name { 'Dulce' }
      lastname { 'Woof' }
      email { Faker::Internet.email }
      password { '123456' }
    end

    trait :invalid_user do
      id { nil }
      name { 'Li' }
      lastname { 'Eu' }
      email { 'email .net' }
      password { '123' }
    end
  end
end
