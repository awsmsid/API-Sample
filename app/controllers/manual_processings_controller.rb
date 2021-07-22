# frozen_string_literal: true

class ManualProcessingsController < ApplicationController
  before_action :verify_api
  before_action :set_manual_processing, only: %i[update]

  def index
    manual_processings = ManualProcessingInteractor.index(params, @user_id)

    render json: JSONAPI::Serializer.serialize(manual_processings, is_collection: true)
  end

  def update
    if @manual_processing.update(process_by: @user_id)
      render json: JSONAPI::Serializer.serialize(@manual_processing),
             status: :ok
    else
      render_errors(@manual_processing)
    end
  end

  private

  def set_manual_processing
    @manual_processing = ManualProcessing.find(params[:id])
  end
end
