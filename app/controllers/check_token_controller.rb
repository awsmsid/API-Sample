# frozen_string_literal: true

class CheckTokenController < ApplicationController
  def create
    user = User.where(email: check_params[:username], token: check_params[:token]).first
    if user.blank?
      render json: {}, status: 401
    else
      render json: {}, status: 200
    end
  end

  private

  def check_params
    permitted = %i[username token]
    params.require(:data)
          .require(:attributes)
          .permit(permitted)
          .transform_keys(&:underscore)
  end
end
