# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user

    mail to: user.email, subject: "Account activation"
  end

  # TODO
  def password_reset(user)
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
