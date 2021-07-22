# frozen_string_literal: true

class ManualProcessing < ApplicationRecord
  validates :receipt_id, presence: true

  def self.create_and_update_receipt(receipt)
    Rails.logger.info "create_and_update_receipt : #{receipt}"
    receipt_status = Receipt.statuses[:complete]
    if incomplete_receipt?(receipt)
      receipt_status = Receipt.statuses[:manual_processing]
      ManualProcessing.create!(receipt_id: receipt.id)
    end
    receipt.status = receipt_status
    receipt.save(validate: false)
  end

  def self.incomplete_receipt?(receipt)
    Rails.logger.info "receipt name blank ? : #{receipt.name.blank?}"
    Rails.logger.info "receipt date blank ? : #{receipt.receipt_date.blank?}"
    Rails.logger.info "total paid blank ? : #{receipt.total_paid.blank?}"
    Rails.logger.info "receipt items blank ? : #{receipt.receipt_items.empty?}"
    receipt.name.blank? ||
      receipt.receipt_date.blank? ||
      receipt.address.blank? ||
      receipt.total_paid.blank? ||
      receipt.receipt_items.empty?
  end
end
