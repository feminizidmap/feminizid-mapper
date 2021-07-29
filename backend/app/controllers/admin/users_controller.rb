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

    def update
      if current_user.id == @user.id
        render json: { error: 'Admin cannot modify their own rile' }, status: :bad_request
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
      (action_name == 'update' || action_name == 'destroy') ? EDIT_ROLES : VIEW_ROLES
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:role, :email)
    end
  end
end
