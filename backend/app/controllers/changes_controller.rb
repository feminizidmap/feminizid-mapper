# frozen_string_literal: true

class ChangesController < ApplicationController
  before_action :authorize_access_request!
  before_action :set_change, only: %i[show update destroy]

  def index
    @changes = Change.all
    render json: @changes
  end

  def show
    render json: @change
  end

  def create
    @change = current_user.changes_made.build(change_params)

    if @change.save
      render json: @change, status: :created, location: changes_url(@change.id)
    else
      render json: @change.errors, status: :unprocessable_entity
    end
  end

  def update
    if @change.update(change_params)
      render json: @change
    else
      render json: @change.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @change.destroy
  end

  private

  def set_change
    @change = Change.find(params[:id])
  end

  def change_params
    params.require(:change).permit(:status)
  end
end
