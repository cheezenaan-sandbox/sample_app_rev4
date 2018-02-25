# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user

    mail to: user.email, subject: "Account activation"
  end
end
