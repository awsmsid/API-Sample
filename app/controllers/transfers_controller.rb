# frozen_string_literal: true

class TransfersController < ApplicationController
  before_action :verify_api

  def create
    response = TransferInteractor.create_transfer(transfer_params, @user_id)
    render json: response[:body], status: response[:code]
  end

  private

  def transfer_params
    permitted = %i[transfer_to amount]
    params.require(:data)
          .require(:attributes)
          .permit(permitted)
          .transform_keys(&:underscore)
          .merge(user_id: @user_id)
  end
end
