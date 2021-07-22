# frozen_string_literal: true

class RewardServicesController < ApplicationController
  before_action :verify_api

  def index
    rewards = RewardService.where(user_id: @user_id).first

    render json: JSONAPI::Serializer.serialize(rewards)
  end

  def create
    response = RewardServiceInteractor.create(reward_services_params)
    render json: response[:body], status: response[:code]
  end

  private

  def reward_services_params
    permitted = %i[user-id]
    params.require(:data)
          .require(:attributes)
          .permit(permitted)
          .transform_keys(&:underscore)
  end
end
