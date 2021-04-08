# frozen_string_literal: true

class FcaseController < ApplicationController
  before_action :authorize_access_request!
  before_action :set_fcase, only: %i[show update destroy]

  ROLES = %w[user reviewer admin].freeze

  def index
    @fcases = Fcase.all
    render json: @fcases, include: 'victims'
  end

  def show
    render json: @fcase
  end

  def create
    @fcase = Fcase.new(fcase_params)
    # @fcase.victim.new

    if @fcase.save
      render json: @fcase, status: :created, location: case_url(@fcase.id)
    else
      render json: @fcase.errors, status: :unprocessable_entity
    end
  end

  def update
    if @fcase.update(fcase_params)
      render json: @fcase
    else
      render json: @fcase.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @fcase.destroy
  end

  def token_claims
    {
      aud: ROLES,
      verify_aud: true
    }
  end

  private

  def set_fcase
    @fcase = Fcase.find(params[:id])
  end

  def fcase_params
    params.require(:fcase).permit(:ident, :sources)
  end
end
