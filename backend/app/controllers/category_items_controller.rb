# frozen_string_literal: true

class CategoryItemsController < ApplicationController
  before_action :authorize_access_request!
  before_action :set_category_item, only: %i[show update destroy]

  def index
    @category_items = CategoryItem.all
    render json: @category_items
  end

  def show
    render json: @category_item
  end

  def create
    @category_item = CategoryItem.new(category_item_params)

    if @category_item.save
      render json: @category_item, status: :created, location: category_items_url(@category_item.id)
    else
      render json: @category_item.errors, status: :unprocessable_entity
    end
  end

  def update
    if @category_item.update(category_item_params)
      render json: @category_item
    else
      render json: @category_item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @category_item.destroy
  end

  private

  def set_category_item
    @category_item = CategoryItem.find(params[:id])
  end

  def category_item_params
    params.require(:category_item).permit(:name,
                                          :slug,
                                          :description,
                                          :category_id,
                                          :category)
  end
end
