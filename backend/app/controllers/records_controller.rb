# frozen_string_literal: true

class RecordsController < ApplicationController
  before_action :authorize_access_request!
  before_action :set_record, only: %i[show update destroy]

  def index
    @records = Record.all
    render json: @records
  end

  def show
    render json: @record
  end

  def create
    @record = Record.new

    if @record.save
      render json: @record, status: :created, location: records_url(@record.id)
    else
      render json: @record.errors, status: :unprocessable_entity
    end
  end

  def update
    if @record.update(record_params)
      render json: @record
    else
      render json: @record.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @record.destroy
  end

  private

  def set_record
    @record = Record.find(params[:id])
  end

  def record_params
    params.require(:record).permit(:identifier)
  end
end
