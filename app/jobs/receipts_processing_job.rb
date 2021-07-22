# frozen_string_literal: true

class ReceiptsProcessingJob < ApplicationJob
  queue_as ENV['UPLOAD_RECEIPTS_QUEUE_NAME']

  def perform(receipt_id)
    Rails.logger.info "perform #{receipt_id}"
    ReceiptProcessingInteractor.process_receipt(receipt_id)
  end
end
