# frozen_string_literal: true

users = User.order(:created_at).take(6)

users.each do |user|
  microposts = (1..50).map do
    {
      content: Faker::Lorem.sentence(5),
      user: user,
    }
  end
  Micropost.seed(microposts)
end
