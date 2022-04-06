# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authorize_access_request!
  before_action :set_verify_user, only: %i[update destroy]

  def me
    render json: current_user
  end

  def index
    @users = User.all
    render json: @users 
  end

  def show
    @user = User.find(params[:id])
    @user.generate_password_token!
    render json: { data: @user, status: :ok, message: 'Success' }
  end

  def update
    if @user.update!(user_params)
      render json: { data: @user, status: :ok, message: 'Success' }
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  private

  def set_verify_user
    if current_user.id == params[:id]
      @user = User.find(params[:id])
    else
      forbidden
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :role)
  end
end
