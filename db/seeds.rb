# frozen_string_literal: true

User.create!(
  name: "Kumiko Oumae",
  email: "anime-eupho@example.com",
  password: "foobar",
  admin: true,
)

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n + 1}@railstutorial.org"
  password = "password"
  User.create!(
    name: name,
    email: email,
    password: password,
  )
end
