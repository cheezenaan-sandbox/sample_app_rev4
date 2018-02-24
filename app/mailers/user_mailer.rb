# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def account_activation(user:, token:)
    @user = user
    @token = token

    mail to: user.email, subject: "Account activation"
  end
end
