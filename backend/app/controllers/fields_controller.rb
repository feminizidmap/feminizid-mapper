# frozen_string_literal: true

class FieldsController < ApplicationController
  before_action :authorize_access_request!
  before_action :set_field, only: %i[show update destroy]

  def index
    @fields = Field.all
    render json: @fields
  end

  def show
    render json: @field
  end

  def create
    @field = Field.new(field_params)

    if @field.save
      render json: @field, status: :created, location: entity_fields_url(@field.id, @field.entity.id)
    else
      render json: @field.errors, status: :unprocessable_entity
    end
  end

  def update
    if @field.update(field_params)
      render json: @field
    else
      render json: @field.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @field.destroy
  end

  private

  def set_field
    @field = Field.find(params[:id])
  end

  def field_params
    params.require(:field).permit(:name,
                                  :description,
                                  :key,
                                  :value,
                                  :feature,
                                  :entity_id)
  end
end
