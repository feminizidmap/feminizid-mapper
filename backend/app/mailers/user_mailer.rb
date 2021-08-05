# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def reset_password(user)
    @user = user
    mail(to: @user.email, subject: 'Reset your password')
  end

  def account_created_by(new_user, current_user)
    @new_user = new_user
    @current_user = current_user
    mail(to: @new_user.email, subject: 'Account created for you')
  end
end
