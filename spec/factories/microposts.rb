# frozen_string_literal: true

FactoryBot.define do
  CONTENT_LENGTH = 140

  factory :micropost do
    trait :dummy do
      sequence(:content) { Faker::StarWars.quote[0..(CONTENT_LENGTH - 1)] }
      sequence(:created_at) { Time.zone.now - 10.minutes }
    end

    trait :most_recent do
      content "Writing a short test"
      created_at { Time.zone.now }
    end

    after(:build) do |micropost|
      micropost.user = FactoryBot.create(:user, :dummy)
    end
  end
end
