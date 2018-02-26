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
      activated true
      activated_at { Time.zone.now }
    end
  end
end
