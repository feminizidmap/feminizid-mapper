# frozen_string_literal: true

class RecordsController < ApplicationController
  before_action :authorize_access_request!
  before_action :set_record, only: %i[show update destroy]

  def index
    @records = Record.all
    render json: @records
  end

  def show
    render json: @record.to_json(include: :sources)
  end

  def create
    @record = Record.new(record_params)

    if @record.save
      render json: @record, status: :created, location: records_url(@record.id)
    else
      render json: @record.errors, status: :unprocessable_entity
    end
  end

  def update
    if @record.update(record_params)
      render json: @record.as_json(include: [:sources, :entities])
    else
      render json: @record.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @record.destroy
  end

  private

  def set_record
    @record = Record.includes(:sources, :entities).find(params[:id])
  end  

  def record_params
    params.require(:record).permit(
      :identifier,
      sources_attributes: [:id, :url],
      entities_attributes: [:id, :name, :description, :_destroy, properties_attributes: [:id, :name, :value, :_destroy]]
    )
  end
  
end
