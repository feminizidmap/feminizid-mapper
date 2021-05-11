# frozen_string_literal: true

class CrimeController < ApplicationController
  before_action :authorize_access_request!
  before_action :set_crime, only: %i[show update destroy]

  ROLES = %w[user reviewer admin].freeze

  def index
    @crimes = Crime.all
    render json: CrimeSerializer.new(@crimes)
  end

  def show
    render json: CrimeSerializer.new(@crime)
  end

  def create
    @crime = Crime.new(crime_params)

    if @crime.save
      render json: @crime, status: :created, location: crime_url(@crime.id)
    else
      render json: @crime.errors, status: :unprocessable_entity
    end
  end

  def update
    if @crime.update(crime_params)
      render json: @crime
    else
      render json: @crime.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @crime.destroy
  end

  def token_claims
    {
      aud: ROLES,
      verify_aud: true
    }
  end

  private

  def set_crime
    @crime = Crime.find(params[:id])
  end

  def crime_params
    params.require(:crime).permit(:fcase_id,
                                  :address,
                                  :location_id,
                                  :cause_of_death_id,
                                  :acts_of_violence_id,
                                  :weaspons_id,
                                  :ftype_id,
                                  :motif_id)
  end
end
