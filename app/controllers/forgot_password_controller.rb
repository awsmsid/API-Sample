# frozen_string_literal: true

class ForgotPasswordController < ApplicationController
  def create
    user = User.find_by_email(forgot_password_params[:email])
    if user.present?

      render json: JSONAPI::Serializer.serialize(ForgotPassword.create_record(user)),
             status: :ok
    else
      render json: {}, status: 404
    end
  end

  private

  def forgot_password_params
    permitted = %i[email]
    params.require(:data)
          .require(:attributes)
          .permit(permitted)
          .transform_keys(&:underscore)
  end
end
