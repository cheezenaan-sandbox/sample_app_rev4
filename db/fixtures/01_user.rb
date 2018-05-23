# frozen_string_literal: true

User.seed do |s|
  s.name = "Kumiko Oumae"
  s.email = "anime-eupho@example.com"
  s.password = "password"
  s.admin = true
  s.activated = true
  s.activated_at = Time.zone.now
end

users = (2..100).map do |n|
  {
    name: Faker::Name.name,
    email: "example-#{n}@railstutorial.org",
    password: "foobar",
    activated: true,
    activated_at: Time.zone.now,
  }
end

User.seed(users)
