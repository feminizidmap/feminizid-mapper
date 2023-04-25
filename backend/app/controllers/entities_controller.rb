# frozen_string_literal: true

class EntitiesController < ApplicationController
  before_action :authorize_access_request!
  before_action :set_entity, only: %i[show update destroy]

  def index
    @entities = Entity.all
    render json: @entities
  end

  def show
    json: @entity.to_json(include: [:fields, :properties])
  end

  def create
    @record = Record.find(params[:record_id])
    @entity = @record.entities.build(entity_params)

    if @entity.save
      render json: @entity, status: :created, location: record_entity_url(@record.id, @entity.id)
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
    params.require(:entity).permit(
      :record_id, :name, :slug, :description,
      fields_attributes: [:id, :name, :value],
      properties_attributes: [:id, :name, :value]
    )
  end
  
end
