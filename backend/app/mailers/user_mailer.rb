# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def reset_password(user)
    @user = user
    mail(to: @user.email, subject: I18n.t('user_mailer.reset_subject'))
  end

  def account_created_by(new_user, current_user)
    @new_user = new_user
    @current_user = current_user
    mail(to: @new_user.email, subject: I18n.t('user_mailer.created_subject'))
  end
end
