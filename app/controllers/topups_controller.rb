# frozen_string_literal: true

class TopupsController < ApplicationController
  before_action :verify_api
  before_action :set_top_ups, only: %i[update]

  def create
    top_up = Topup.new(top_ups_params)

    if top_up.save
      render json: JSONAPI::Serializer.serialize(top_up), status: :ok
    else
      render_errors(top_up)
    end
  end

  def index
    top_ups = Topup.where(user_id: @user_id)
    render json: JSONAPI::Serializer.serialize(top_ups, is_collection: true)
  end

  def update
    if @top_up.update(top_ups_update_params)
      render json: JSONAPI::Serializer.serialize(@top_up),
             status: :ok
    else
      render_errors(@top_up)
    end
  end

  private

  def top_ups_params
    permitted = %i[amount method result transaction_id]
    params.require(:data)
          .require(:attributes)
          .permit(permitted)
          .merge(user_id: @user_id)
          .transform_keys(&:underscore)
  end

  def top_ups_update_params
    permitted = %i[result]
    params.require(:data)
          .require(:attributes)
          .permit(permitted)
          .transform_keys(&:underscore)
  end

  def set_top_ups
    @top_up = Topup.find_by_transaction_id(params[:id])
  end
end
