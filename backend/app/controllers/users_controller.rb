# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authorize_access_request!
  before_action :set_verify_user, only: %i[update destroy]

  def me
    render json: current_user
  end

  def update
    @user.update!(user_params)
    JWTSessions::Session.new(namespace: "user_#{@user.id}").flush_namespaced_access_tokens
    render json: @user
  end

  def destroy
    @user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
    return false unless current_user == @user.id
  end

  def user_params
    params.require(:user).permit(:role,
                                 :email,
                                 :password,
                                 :password_confirmation)
  end
end
