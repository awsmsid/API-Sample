# frozen_string_literal: true

class BillPaymentsController < ApplicationController
  before_action :verify_api

  def create
    response = BillPaymentInteractor.create_bill_payment(bill_payment_params, @user_id)
    render json: response[:body], status: response[:code]
  end

  def index
    bill_payments = BillPayment.where(user_id: @user_id)
    render json: JSONAPI::Serializer.serialize(bill_payments, is_collection: true)
  end

  private

  def bill_payment_params
    permitted = %i[account_no utility_type_id bill_company_id bill_amount]
    params.require(:data)
          .require(:attributes)
          .permit(permitted)
          .transform_keys(&:underscore)
  end
end
