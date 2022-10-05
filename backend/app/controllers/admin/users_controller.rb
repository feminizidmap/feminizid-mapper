# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    before_action :authorize_access_request!
    before_action :set_user, only: %i[show update destroy]
    VIEW_ROLES = %w[admin reviewer].freeze
    EDIT_ROLES = %w[admin].freeze

    def index
      @users = User.all

      render json: @users.as_json
    end

    def show
      render json: @user
    end

    def create
      u = User.new(user_params)
      u.password = SecureRandom.hex(14)
      if u.save!
        UserMailer.account_created_by(u, current_user).deliver_now
        render json: { status: :ok, message: 'User created' }
      else
        render json: { error: 'Could not create user', status: :bad_request }
      end
    end

    def update
      if current_user.id == @user.id
        render json: { error: 'Admin cannot modify their own role' }, status: :bad_request
      else
        @user.update!(user_params)
        JWTSessions::Session.new(namespace: "user_#{@user.id}").flush_namespaced_access_tokens
        render json: @user
      end
    end

    def destroy
      @user.destroy
    end

    def token_claims
      {
        aud: allowed_aud,
        verify_aud: true
      }
    end

    private

    def allowed_aud
      %w[create update destroy].include?(action_name) ? EDIT_ROLES : VIEW_ROLES
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:role, :email, :name)
    end
  end
end
