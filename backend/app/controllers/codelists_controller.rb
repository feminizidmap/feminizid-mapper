# frozen_string_literal: true

class CodelistsController < ApplicationController
  before_action :authorize_access_request!
  before_action :set_codelist, only: %i[show update destroy]

  ROLES = %w[admin].freeze

  def index
    codelists = Codelist.all
    render json: codelists
  end

  def show
    render json: @codelist
  end

  def create
    codelist = Codelist.new(codelist_params)
    if codelist.save
      render json: codelist, status: :created
    else
      render json: codelist.errors, status: :unprocessable_entity
    end
  end

  def update
    if @codelist.update(codelist_params)
      render json: @codelist
    else
      render json: @codelist.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @codelist.destroy
  end

  def token_claims
    {
      aud: ROLES,
      verify_aud: true
    }
  end

  private

  def set_codelist
    @codelist = Codelist.find(params[:id])
  end

  def codelist_params
    params.require(:codelist).permit(:code,
                                     :name,
                                     :lang,
                                     :description)
  end
end
