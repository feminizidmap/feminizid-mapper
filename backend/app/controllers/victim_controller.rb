# frozen_string_literal: true

class VictimController < ApplicationController
  before_action :authorize_access_request!
  before_action :set_victim, only: %i[show update destroy]

  ROLES = %w[user reviewer admin].freeze

  def index
    victims = Victim.all
    render json: VictimSerializer.new(victims)
  end

  def show
    render json: VictimSerializer.new(@victim)
  end

  def create
    victim = Victim.new(victim_params)
    if victim.save
      render json: victim, status: :created, location: victim_url(victim.id)
    else
      render json: victim.errors, status: :unprocessable_entity
    end
  end

  def update
    if @victim.update(victim_params)
      render json: @victim
    else
      render json: @victim.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @victim.destroy
  end

  def token_claims
    {
      aud: ROLES,
      verify_aud: true
    }
  end

  private

  def set_victim
    @victim = Victim.find(params[:id])
  end

  def victim_params
    params.require(:victim).permit(:firstname,
                                   :lastname,
                                   :age,
                                   :civil_status_id,
                                   :educational_background_id,
                                   :address,
                                   :citizenship_type_id,
                                   :citizenship,
                                   :legal_status_id,
                                   :drunk_id,
                                   :drug_influence_id,
                                   :previous_reports_of_violence_id,
                                   :fcase_id)
  end
end
