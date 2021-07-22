# frozen_string_literal: true

class WithdrawController < ApplicationController
  before_action :verify_api

  def create
    response = WithdrawInteractor.create_withdraw(withdraw_params, @user_id)
    render json: response[:body], status: response[:code]
  end

  def index
    withdraws = WithdrawInteractor.index(@user_id)
    render json: JSONAPI::Serializer.serialize(withdraws, is_collection: true)
  end

  private

  def withdraw_params
    permitted = %i[account_to amount]
    params.require(:data)
          .require(:attributes)
          .permit(permitted)
          .transform_keys(&:underscore)
  end
end
