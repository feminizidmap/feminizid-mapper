# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def reset_password(user)
    @user = user
    mail(to: @user.email, subject: 'Reset your password')
  end
end
