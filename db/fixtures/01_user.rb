# frozen_string_literal: true

User.seed do |s|
  s.name = "Kumiko Oumae"
  s.email = "anime-eupho@example.com"
  s.password = "password"
  s.admin = true
end

users = (2..100).map do |n|
  {
    name: Faker::Name.name,
    email: "example-#{n}@railstutorial.org",
    password: "foobar",
  }
end

User.seed(:id, users)

account_activations = User.order(:id).pluck(:id).map do |user_id|
  {
    user_id: user_id,
    digest: SecureDigest.digest(SecureToken.create),
    activated_at: Time.zone.now,
  }
end

User::AccountActivation.seed(:id, account_activations)
