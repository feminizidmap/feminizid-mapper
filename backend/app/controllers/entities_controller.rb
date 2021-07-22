# frozen_string_literal: true

class EntitiesController < ApplicationController
  before_action :authorize_access_request!
  before_action :set_entity, only: %i[show update destroy]

  def index
    @entities = Entity.all
    render json: @entities
  end

  def show
    render json: @entity
  end

  def create
    @entity = Entity.new

    if @entity.save
      render json: @entity, status: :created, location: entities_url(@entity.id)
    else
      render json: @entity.errors, status: :unprocessable_entity
    end
  end

  def update
    if @entity.update(entity_params)
      render json: @entity
    else
      render json: @entity.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @entity.destroy
  end

  private

  def set_entity
    @entity = Entity.find(params[:id])
  end

  def entity_params
    params.require(:entity).permit(:record_id,
                                   :name,
                                   :slug)
  end
end
