# frozen_string_literal: true

class RecordsController < ApplicationController
  before_action :authorize_access_request!
  before_action :set_record, only: %i[show update destroy]

  def index
    @records = Record.all
    render json: @records
  end

  def show
    render json: @record.to_json(include: [:sources, { entities: { include: [:fields, :properties] } }])
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
    # Delete sources that are missing from the request
    source_ids_in_request = params[:record][:sources_attributes].map { |s| s[:id] }
    @record.sources.where.not(id: source_ids_in_request).destroy_all
    
    if @record.update(record_params)
      render json: @record.as_json(include: [:sources, { entities: { include: [:fields, :properties] } }])
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
      sources_attributes: [:id, :url, :record_id, :created_at, :updated_at],
      entities_attributes: [
        :id, 
        :name, 
        :description,
        :slug, 
        :record_id,
        fields_attributes: [:id, :name, :value], 
        properties_attributes: [:id, :name, :value]
      ]
    )
  end
  
end
