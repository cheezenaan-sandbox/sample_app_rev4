# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    trait :kumiko do
      name "Kumiko Oumae"
      email "kumiko-eupho@example.com"
      password "euphonium"
    end

    trait :asuka do
      name "Asuka Tanaka"
      email "asuka-eupho@example.com"
      password "euphonium"
    end

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

    trait :with_microposts do
      after(:create) do |user|
        50.times { FactoryBot.create(:micropost, :dummy, user: user) }
      end
    end
  end
end
