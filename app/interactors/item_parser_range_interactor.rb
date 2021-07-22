# frozen_string_literal: true

class ItemParserRangeInteractor # rubocop:disable Metrics/ClassLength
  def self.find_items_for_item_range_2(parsed_txt, items_range, amount)
    items = []
    price = []
    total_items = []
    ((items_range[0] + 1)...items_range[1]).each { |i| items << parsed_txt[i] }
    price_range = parsed_txt.each_index.select { |index| parsed_txt[index] == (amount + ' ') }
    price_range = price_range[0...-1].last(2)
    ((price_range[0] + 2)...price_range[1]).each { |i| price << parsed_txt[i] }
    price.shift if price[0].match?(/\d{1,}\.(\d{2}| \w{1,})/)
    total_items = total_items_item_range2(items, price, total_items)
    total_items
  rescue StandardError => exception
    Rails.logger.error exception.backtrace
    nil
  end

  def self.total_items_item_range2(items, price, total_items)
    items.each do |item|
      if item.match?(/(\$\d{1,}\.\d{1,} ea )|(Qty)|(Oty)|(CARO:\.{13}\d{4} T)/)
      elsif item.match?(/(\$\d{1,3}\.\d{1,2})|(\d{1,3}\.\d{1,2})/)
        total_items[total_items.length - 1]['price'] = item if total_items.present?
      elsif item.match?(/^\d{1,} $/)
        total_items[total_items.length - 1]['quantity'] = item
      else
        total_items << add_single_item(item, 1, price[total_items.length])
      end
    end
    total_items
  rescue StandardError => exception
    Rails.logger.error exception
    nil
  end

  def self.add_single_item(item, quantity, price)
    single_item = {}
    single_item['name'] = item
    single_item['quantity'] = quantity
    single_item['price'] = price
    single_item
  end

  def self.find_items(parsed_txt)
    pattern = /(Scot User \d{0,4} )|(Total|Total |TOTAL |TOTAL)/
    items_range = parsed_txt.each_index.select { |index| parsed_txt[index][pattern] }[0, 2]
    items = []
    ((items_range[0] + 1)...items_range[1]).each { |i| items << parsed_txt[i] }
    total_items = []
    items.each do |item|
      single_item = {}
      each_item = item.split(' $')
      single_item['name'] = each_item[0]
      single_item['price'] = each_item[1]
      single_item['quantity'] = 1
      total_items << single_item
    end
    total_items
  rescue StandardError => exception
    Rails.logger.error exception
    nil
  end

  def self.create_receipt_items(items, receipt)
    return if items.blank?
    items.each do |item|
      price = find_price(item)
      item_name = item['name'].gsub(/\*|\.|\%|x{1}%/, '').strip
      if receipt.class == ReceiptPartial
        receipt.receipt_items.new(item_name: item_name, quantity: item['quantity'],
                                  price: price, receipt_id: receipt&.receipt&.id)
      else
        receipt.receipt_items.new(item_name: item_name, quantity: item['quantity'],
                                  price: price)
      end
      receipt.save
    end
  rescue StandardError => exception
    Rails.logger.error exception
    nil
  end

  def self.find_price(item)
    price = item['price'].nil? ? 0 : item['price'].gsub(/\.\s|\,\s/, '.')
    price = price.gsub(/\s|[a-zA-Z]|\$|\-|\oo|\*/, '') unless price.eql? 0
    price = '$' + price.gsub(/\.$/, '') unless price.eql? 0
    price
  rescue StandardError => exception
    Rails.logger.error exception
    nil
  end

  def self.total_paid_amount(params)
    file_parse = find_file_parse(params)
    params_txt = file_parse[1].split(/TOTAL|Total/, 2)[1]
    params_txt = params_txt.gsub(/(You saved: \$(\d{1,4}(\.)\d{1,2}))|
                              |(\-\$(\d{1,4}(\.)\d{1,2}))/, '')
    total_paid = params_txt.gsub(/ b /, '.')[/\$(\d{1,4}(\.)\d{1,2})/]
    total_paid
  rescue StandardError => exception
    Rails.logger.error exception
    nil
  end

  def self.find_file_parse(params)
    file_parse = if params.split('"FileParseExitCode":1,').length == 1
                   params.split('"FileParseExitCode": 1,')
                 else
                   params.split('"FileParseExitCode":1,')
                 end
    file_parse
  end
end
