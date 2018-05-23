# frozen_string_literal: true

user = User.first

users = User.all
following = users[2..50].map do |followed|
  {
    follower_id: user.id,
    followed_id: followed.id,
  }
end
Relationship.seed(following)

followers = users[3..40].map do |follower|
  {
    follower_id: follower.id,
    followed_id: user.id,
  }
end
Relationship.seed(followers)
