class PasswordResetsController < ApplicationController
  before_action :set_user, only: [:edit]

  def create
    user = User.find_by(email: params[:email])
    if user
      user.generate_password_token!
      UserMailer.reset_password(user).deliver_now
    end

    render json: :ok
  end

  def edit
    render json: :ok
  end

  private

  def set_user
    @user = USer.find_by(reset_password_token: params[:token])
    raise ResetPasswordError unless @user&.reset_password_token_expires_at && @user.reset_password_token_expires_at > Time.now
  end
end
