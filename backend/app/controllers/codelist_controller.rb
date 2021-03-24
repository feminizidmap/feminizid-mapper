# frozen_string_literal: true

class CodelistController < ApplicationController
  before_action :authorize_access_request!
  before_action :set_codelist, only: %i[show update destroy]

  VIEW_ROLES = %w[user reviewer admin].freeze
  EDIT_ROLES = %w[admin].freeze

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
      render json: codelist, status: :created, location: codelist_url(codelist.id)
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
      aud: allowed_aud,
      verify_aud: true
    }
  end

  private

  def allowed_aud
    return VIEW_ROLES if action_name == 'index' || action_name == 'show'

    EDIT_ROLES
  end

  def set_codelist
    @codelist = Codelist.find(params[:id])
  end

  def codelist_params
    params.require(:codelist).permit(:identifier,
                                     :name,
                                     :lang,
                                     :description)
  end
end
