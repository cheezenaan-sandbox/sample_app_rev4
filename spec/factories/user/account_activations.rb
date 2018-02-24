# frozen_string_literal: true

FactoryBot.define do
  factory :account_activation, class: "User::AccountActivation" do
    digest { SecureDigest.digest(SecureToken.create) }
    activated_at { Time.zone.now }
  end
end
