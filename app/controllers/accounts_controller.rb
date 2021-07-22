# frozen_string_literal: true

class AccountsController < ApplicationController
  before_action :verify_api

  def create
    account = Account.new(account_params.merge(user_id: @user_id))

    if account.save
      render json: JSONAPI::Serializer.serialize(account), status: :ok
    else
      render_errors(account)
    end
  end

  def index
    accounts = Account.all
    render json: JSONAPI::Serializer.serialize(accounts, is_collection: true)
  end

  private

  def account_params
    permitted = %i[bank_name bsb account_number account_name]
    params.require(:data)
          .require(:attributes)
          .permit(permitted)
          .transform_keys(&:underscore)
  end
end
