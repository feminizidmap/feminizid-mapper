# frozen_string_literal: true

class PasswordResetsController < ApplicationController
  before_action :set_user, only: %i[edit update]
  KEYS = %i[password password_confirmation].freeze

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

  def update
    @user.update!(password_params)
    @user.clear_password_token!
    JWTSessions::Session.new(namespace: "user_#{@user.id}").flush_namespaced
    render json: :ok
  end

  private

  def set_user
    @user = User.find_by(reset_password_token: params[:token])
    unless @user&.reset_password_token_expires_at &&
           @user.reset_password_token_expires_at > Time.zone.now
      raise ResetPasswordError
    end
  end

  def password_params
    params.tap { |p| p.require(KEYS) }.permit(*KEYS)
  end
end
