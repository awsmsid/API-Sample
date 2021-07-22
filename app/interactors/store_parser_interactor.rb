# frozen_string_literal: true

class StoreParserInteractor # rubocop:disable Metrics/ClassLength
  def self.create_and_parse_receipt(parser_params, user_id)
    if parser_params.class != Array
      status = Receipt.statuses[:processing]
      receipt = Receipt.new(picture: parser_params, user_id: user_id, status: status)
      receipt.save
      ReceiptsProcessingJob.perform_later(receipt.id)
      receipt
    else
      MultiReceiptParserInteractor.save_receipts(parser_params, user_id)
    end
  end

  def self.process_receipt(receipt_id)
    receipt = Receipt.find(receipt_id)
    result = OCRSpaceService.upload('https:' + receipt.picture.url(:original))
    ocr_result = JSON result
    Rails.logger.info receipt
    Rails.logger.info ocr_result
    if ocr_result['ParsedResults'].blank?
      ManualProcessing.create_and_update_receipt(receipt)
      ocr_result['ErrorMessage']
    else
      create_receipt(result, receipt)
      receipt
    end
  end

  def self.store(parser_params)
    STORE_NAMES.select { |w| parser_params.to_s.downcase.include?(w.downcase) }.first
  end

  def self.response_message_code(receipt)
    if receipt.class == Array
      if receipt.first.class == ReceiptPartial
        { body: JSONAPI::Serializer.serialize(receipt.first.receipt), code: 200 }
      else
        { body: { 'error' => receipt.first }, code: 400 }
      end
    else
      { body: JSONAPI::Serializer.serialize(receipt), code: 200 }
    end
  end

  def self.create_receipt(parser_params, receipt)
    store_name = store(parser_params)
    receipt_date = find_date(parser_params)
    total_paid = ReceiptParserInteractor.total_paid_amount(parser_params)
    address = find_address(parser_params)
    if store_name && receipt_date && total_paid && address
      receipt = ReceiptInteractor.update_receipt(receipt,
                                                 store_name,
                                                 receipt_date,
                                                 total_paid,
                                                 address)
      ReceiptProcessingInteractor.update_reward_services(receipt)
      ItemParserInteractor.find_and_create_receipt_items(parser_params, receipt)
    else
      ManualProcessing.create_and_update_receipt(receipt)
    end

    receipt
  end

  def self.find_date(params)
    date_pattern = %r{(\d{1,2}(\/|\.)\d{2,4}(\/|\.)\d{4})|(\d{1,2}(\/|\.)\d{1,2}(\/|\.)\d{2})}
    date = params.to_s[date_pattern] # find date with regex
    return unless date
    date_array = date.split(%r{\/|\.}) # split date to add a prefix for year
    if date_array.last.length == 2
      date = date_array.replace([date_array.first,
                                 date_array.second,
                                 '20' + date_array.third])
                       .join('/') # create a valid date with prefix 20
    end
    ReceiptParserInteractor.find_date_time(params, date)
  end

  def self.find_address(params)
    file_parse = if params.split('"FileParseExitCode":1,').length == 1
                   params.split('"FileParseExitCode": 1,')
                 else
                   params.split('"FileParseExitCode":1,')
                 end
    address_txt = file_parse[1].gsub(/\\r\\n/, "\n").split("\n")
    state_position = ReceiptParserInteractor.find_state_position(address_txt)
    address = if state_position.present?
                ReceiptParserInteractor.find_state_zip_address(address_txt,
                                                               state_position,
                                                               zip_pattern)
              else
                find_zip_address(address_txt)
              end
    address.present? ? address.strip.squeeze(' ') : nil
  rescue StandardError => exception
    Rails.logger.error exception.backtrace
    nil
  end

  def self.zip_pattern
    # rubocop:disable LineLength
    /(0[289][0-9]{2})|(0[89][0-9]{2})|([1-2]{1}[0-9]{1}[0-9]{2})|(2[9][0-1]{1}[1-4]{1})|([3-7]{1}[0-5]{1}[0-9]{2})|([7-9]{1}[8-9]{1}[0-9]{2})/
    # rubocop:enable LineLength
  end

  def self.find_zip_address(address_txt)
    zip_code_position = address_txt.index(address_txt.select do |i|
                                            i[/MERCH ID:(|\s)\d{1,20}/]
                                          end
                                                     .first)
    return if zip_code_position.blank?
    address_txt[zip_code_position - 2] + ' ' + address_txt[zip_code_position - 1]
  end
end
