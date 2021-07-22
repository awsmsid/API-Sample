# frozen_string_literal: true

class ReceiptProcessingInteractor
  def self.process_receipt(receipt_id)
    receipt = Receipt.find(receipt_id)
    if receipt.receipt_partials.blank?
      StoreParserInteractor.process_receipt(receipt_id)
    else
      partial_process_receipt(receipt_id)
    end
  end

  def self.partial_process_receipt(receipt_id)
    Rails.logger.info "partial_process_receipt with id #{receipt_id}"
    receipt = Receipt.find(receipt_id)
    receipt.receipt_partials.each do |receipt_partial|
      result, _ocr_result = find_ocr_result(receipt_partial)
      create_receipt(result, receipt_partial)
    end

    update_receipt(receipt)

    ManualProcessing.create_and_update_receipt(receipt)

    update_reward_services(receipt)
  end

  def self.find_ocr_result(receipt_partial)
    result = OCRSpaceService.upload('https:' + receipt_partial.picture.url(:original))
    ocr_result = JSON result
    Rails.logger.info receipt_partial
    Rails.logger.info ocr_result
    [result, ocr_result]
  end

  def self.create_receipt(parser_params, receipt_partial)
    receipt_partial.name = StoreParserInteractor.store(parser_params)
    receipt_partial.receipt_date = StoreParserInteractor.find_date(parser_params)
    receipt_partial.total_paid = ReceiptParserInteractor.total_paid_amount(parser_params)
    receipt_partial.address = StoreParserInteractor.find_address(parser_params)
    receipt_partial.status = Receipt.statuses[:complete]
    receipt_partial.save
    ItemParserInteractor.find_and_create_receipt_items(parser_params, receipt_partial)
    receipt_partial
  end

  def self.update_receipt(receipt)
    return if receipt&.receipt_partials&.map(&:name)&.compact&.uniq&.length != 1
    receipt.name = receipt_name(receipt)
    receipt.receipt_date = receipt_date(receipt)
    receipt.total_paid = receipt_total_paid(receipt)
    receipt.address = receipt_address(receipt)
    receipt.status = Receipt.statuses[:complete]
    receipt.mivi_credit = MiviCreditInteractor.credit(receipt.total_paid)
    receipt.save(validate: false)
    update_receipt_items(receipt)
  end

  def self.receipt_name(receipt)
    receipt&.receipt_partials&.map(&:name)&.reject { |rp| rp.to_s.empty? }.first
  end

  def self.receipt_date(receipt)
    receipt&.receipt_partials&.map(&:receipt_date)&.reject { |rp| rp.to_s.empty? }.first
  end

  def self.receipt_total_paid(receipt)
    receipt&.receipt_partials&.map(&:total_paid)&.reject { |rp| rp.to_s.empty? }.first
  end

  def self.receipt_address(receipt)
    receipt&.receipt_partials&.map(&:address)&.reject { |rp| rp.to_s.empty? }.first
  end

  def self.update_receipt_items(receipt)
    receipt.receipt_partials.each do |rp|
      rp.receipt_items.each do |ri|
        nri = ri.dup
        nri.receipt = receipt
        nri.save
      end
    end
  end

  def self.update_reward_services(receipt)
    Rails.logger.info 'update reward services'
    reward_service = RewardService.find_by_user_id(receipt.user_id)
    return if reward_service.blank?
    reward_service.game_token = receipt.mivi_credit + reward_service.game_token
    reward_service.save(validate: false)
  end
end
