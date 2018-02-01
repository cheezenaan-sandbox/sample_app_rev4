# frozen_string_literal: true

module UsersHelper
  def gravatar_for(user)
    return unless user&.email.present?

    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = Pathname.new("https://secure.gravatar.com/avatar/").join(gravatar_id)
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
