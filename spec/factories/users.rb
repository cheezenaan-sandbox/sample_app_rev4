# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name "Kumiko Oumae"
    email "anime@example.com"
    password "euphonium"

    trait :dummy do
      sequence(:name) { |n| "User #{n}" }
      sequence(:email) { |n| "user-#{n}@example.com" }
      password "foobar"
    end

    trait :admin do
      admin true
    end

    trait :activated do
      after(:create) do |user|
        FactoryBot.create(:account_activation, user: user)
      end
    end
  end
end
