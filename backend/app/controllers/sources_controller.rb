# frozen_string_literal: true

class SourcesController < ApplicationController
  before_action :authorize_access_request!
  before_action :set_source, only: %i[show update destroy]

  def index
    @sources = Source.all
    render json: @sources
  end

  def show
    render json: @source
  end

  def create
    @source = Source.new

    if @source.save
      render json: @source, status: :created, location: sources_url(@source.id)
    else
      render json: @source.errors, status: :unprocessable_entity
    end
  end

  def update
    if @source.update(source_params)
      render json: @source
    else
      render json: @source.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @source.destroy
  end

  private

  def set_source
    @source = Source.find(params[:id])
  end

  def source_params
    params.require(:source).permit(:url, :record_id)
  end
end
