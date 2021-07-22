# frozen_string_literal: true

class ReceiptParserInteractor
  def self.total_paid_amount(params)
    file_parse = if params.split('"FileParseExitCode":1,').length == 1
                   params.split('"FileParseExitCode": 1,')
                 else
                   params.split('"FileParseExitCode":1,')
                 end
    params_txt = file_parse[0].split(/TOTAL|Total/, 2)[1]
    return if params_txt.blank?
    params_txt = params_txt.gsub(/(You saved: \$(\d{1,4}(\.)\d{1,2}))|
                                  |(\-\$(\d{1,4}(\.)\d{1,2}))/, '')
    total_paid = params_txt.gsub(/ b /, '.')[/\$(\d{1,4}(\.)\d{1,2})/]
    total_paid
  end

  def self.find_state_position(address_txt)
    STATE_NAMES.map do |state|
      address_txt.index { |s| s.include?((state + ' ')) }
    end.compact.uniq.first
  end

  def self.find_state_zip_address(address_txt, state_position, zip_pattern)
    address = address_txt[state_position]
    address = address_txt[state_position - 1] + ' ' + address_txt[state_position] if
              address[zip_pattern]
    zip_code_position = address_txt.index(address_txt.select do |i|
                                            i[/MERCH ID:(|\s)\d{1,20}/]
                                          end
                                                     .first)
    if zip_code_position.blank?
      address = find_zip_code(address, address_txt, state_position) if
                address[zip_pattern].blank?
    else
      address = address_txt[zip_code_position - 3] + '' +
                address_txt[zip_code_position - 2] + ' ' +
                address_txt[zip_code_position - 1]
    end
    address
  end

  def self.find_zip_code(address, address_txt, state_position)
    temp_txt = []
    [1, 2, 3, 4].each { |i| temp_txt << address_txt[state_position + i] }
    zip = temp_txt.collect { |x| x.strip || x }.join(' ')[/\d{4}$/]
    address += zip unless zip.blank? || zip.include?('0000')
    address
  end

  def self.find_date_time(params, date)
    time_pattern = /(\d{1}\:\d{2}:\d{2}|\d{2}\:\d{2}:\d{2}|\d{2}\:\d{2})/
    time = params.to_s[time_pattern] # Find time with regex
    time_date_pattern = %r{(\d{1,2}(\/|\.)\d{1,2}(\/|\.)\d{2,4})\s\d{1,2}\.\d{1,2}|
                           (\d{1,2}(\/|\.)\d{1,2}(\/|\.)\d{2,4}\s\d{1,2}\.\d{1,2}\.\d{1,2})|
                           (\d{1,2}(\/|\.)\d{1,2}(\/|\.)\d{2,4}\s\d{1,2}\:\d{1,2})|
                           (\d{1,2}(\/|\.)\d{1,2}(\/|\.)\d{2,4}\s\d{1,2}\:\d{1,2}\:\d{1,2})}

    time_plus_date = params.to_s[time_date_pattern] # Find date and time with regex
    # Replace dot with colon to make date and time valid
    time = params.to_s[time_plus_date].split(' ')[1].tr('.', ':') if time_plus_date.present?
    begin
      Time.zone.parse(date + ' ' + (time.presence || '')) # Parse date and time
    rescue StandardError => exception
      Rails.logger.error exception.backtrace
      nil
    end
  end

  def self.delete(id)
    receipt = Receipt.find(id)
    receipt.is_deleted = true
    receipt.deleted_at = Time.current
    receipt.save(validate: false)
    receipt
  end
end
