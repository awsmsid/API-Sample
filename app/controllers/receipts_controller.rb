# frozen_string_literal: true

class ReceiptsController < ApplicationController
  before_action :verify_api
  before_action :set_receipt, only: %i[update receipts_reject]

  def index
    receipts = ReceiptInteractor.user_history(@user_id,
                                              params[:order_by],
                                              params[:order_type])
    render json: JSONAPI::Serializer.serialize(receipts, is_collection: true)
  end

  def show
    receipt = Receipt.find_by_id(params[:id])
    render json: JSONAPI::Serializer.serialize(receipt)
  end

  def update
    if ReceiptInteractor.update_receipt_status(@receipt, receipt_params)
      render json: JSONAPI::Serializer.serialize(@receipt),
             status: :ok
    else
      render_errors(@receipt)
    end
  end

  def destroy
    receipt = ReceiptParserInteractor.delete(params[:id])
    render json: JSONAPI::Serializer.serialize(receipt)
  end

  def receipts_reject
    response = ReceiptInteractor.receipts_reject(@receipt)
    render json: response[:body], status: response[:code]
  end

  private

  def receipt_params
    permitted = %i[name receipt_date address total_paid status]
    nested = %i[item_name quantity price]
    params.require(:data)
          .require(:attributes)
          .permit(permitted, receipt_items_attributes: nested).merge(manual_entry_by: @user_id)
          .transform_keys(&:underscore)
  end

  def set_receipt
    @receipt = Receipt.find(params[:id])
  end
end
