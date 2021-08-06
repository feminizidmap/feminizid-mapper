# frozen_string_literal: true

class AttributesController < ApplicationController
  before_action :authorize_access_request!
  before_action :set_attribute, only: %i[show update destroy]

  def index
    @attributes = Attribute.all
    render json: @attributes
  end

  def show
    render json: @attribute
  end

  def create
    @attribute = Attribute.new(attribute_params)

    if @attribute.save
      render json: @attribute, status: :created, location: entity_attributes_url(@attribute.id, @attribute.entity.id)
    else
      render json: @attribute.errors, status: :unprocessable_entity
    end
  end

  def update
    if @attribute.update(attribute_params)
      render json: @attribute
    else
      render json: @attribute.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @attribute.destroy
  end

  private

  def set_attribute
    @attribute = Attribute.find(params[:id])
  end

  def attribute_params
    params.require(:attribute).permit(:entity_id,
                                      :category_item_id,
                                      :category_id)
  end
end
