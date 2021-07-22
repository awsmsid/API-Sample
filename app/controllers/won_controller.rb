# frozen_string_literal: true

class WonController < ApplicationController
  before_action :verify_api

  def create
    response = WonInteractor.create_won(won_params, @user_id)
    render json: response[:body], status: response[:code]
  end

  private

  def won_params
    permitted = %i[level]
    params.require(:data)
          .require(:attributes)
          .permit(permitted)
          .transform_keys(&:underscore)
  end
end
