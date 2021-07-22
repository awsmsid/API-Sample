# frozen_string_literal: true

class MultiReceiptParserInteractor
  def self.save_receipts(parser_params, user_id)
    receipts = []
    status = Receipt.statuses[:processing]
    receipt = Receipt.new(user_id: user_id, status: status)
    receipt.save(validate: false)
    parser_params.each do |receipt_params|
      receipts << ReceiptPartial.create(picture: receipt_params,
                                        receipt_id: receipt.id,
                                        user_id: user_id)
    end
    ReceiptsProcessingJob.perform_later(receipt.id)
    receipts
  end
end
