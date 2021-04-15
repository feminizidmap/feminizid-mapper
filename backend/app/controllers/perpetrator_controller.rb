# frozen_string_literal: true

class PerpetratorController < ApplicationController
  before_action :authorize_access_request!
  before_action :set_perpetrator, only: %i[show update destroy]

  ROLES = %w[user reviewer admin].freeze

  def index
    perpetrators = Perpetrator.all
    render json: PerpetratorSerializer.new(perpetrators)
  end

  def show
    render json: PerpetratorSerializer.new(@perpetrator)
  end

  def create
    perpetrator = Perpetrator.new(perpetrator_params)
    if perpetrator.save
      render json: perpetrator, status: :created, location: perpetrator_url(perpetrator.id)
    else
      render json: perpetrator.errors, status: :unprocessable_entity
    end
  end

  def update
    if @perpetrator.update(perpetrator_params)
      render json: @perpetrator
    else
      render json: @perpetrator.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @perpetrator.destroy
  end

  def token_claims
    {
      aud: ROLES,
      verify_aud: true
    }
  end

  private

  def set_perpetrator
    @perpetrator = Perpetrator.find(params[:id])
  end

  def perpetrator_params
    params.require(:perpetrator).permit(:firstname,
                                        :lastname,
                                        :age,
                                        :gender_id,
                                        :civil_status_id,
                                        :educational_background_id,
                                        :citizenship_type_id,
                                        :citizenship,
                                        :legal_status_id,
                                        :alcohol_influence_id,
                                        :drug_influence_id,
                                        :previous_psychological_condition_id,
                                        :previous_criminal_record_id,
                                        :fcase_id)
  end
end
