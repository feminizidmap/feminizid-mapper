# frozen_string_literal: true

class SystemSettingsController < ApplicationController
  before_action :authorize_access_request!
  before_action :set_system_setting, only: %i[show update destroy]

  ROLES = %w[admin].freeze

  def index
    system_settings = SystemSetting.all
    render json: system_settings
  end

  def show
    render json: @system_setting
  end

  def create
    system_setting = SystemSetting.new(system_setting_params)
    if system_setting.save
      render json: system_setting, status: :created, location: system_setting_url(system_setting.id)
    else
      render json: system_setting.errors, status: :unprocessable_entity
    end
  end

  def update
    if @system_setting.update(system_setting_params)
      render json: @system_setting
    else
      render json: @system_setting.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @system_setting.destroy
  end

  def token_claims
    {
      aud: ROLES,
      verify_aud: true
    }
  end

  private

  def set_system_setting
    @system_setting = SystemSetting.find(params[:id])
  end

  def system_setting_params
    params.require(:system_setting).permit(:key,
                                           :value)
  end
end
