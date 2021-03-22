# frozen_string_literal: true

class CodelistItemsController < ApplicationController
  before_action :authorize_access_request!
  before_action :set_codelist_item, only: %i[show update destroy]

  VIEW_ROLES = %w[user reviewer admin].freeze
  EDIT_ROLES = %w[admin].freeze

  def index
    codelists = CodelistItem.all
    render json: codelists
  end

  def show
    render json: @codelist_item
  end

  def create
    codelist = CodelistItem.new(codelist_item_params)
    if codelist.save
      render json: codelist, status: :created, location: codelist_items_url(codelist.id)
    else
      render json: codelist.errors, status: :unprocessable_entity
    end
  end

  def update
    if @codelist_item.update(codelist_item_params)
      render json: @codelist_item
    else
      render json: @codelist_item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @codelist_item.destroy
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

  def set_codelist_item
    @codelist_item = CodelistItem.find(params[:id])
  end

  def codelist_item_params
    params.require(:codelist_item).permit(:identifier,
                                          :codelist,
                                          :name,
                                          :lang,
                                          :description)
  end
end
