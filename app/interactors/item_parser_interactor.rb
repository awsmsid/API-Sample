# frozen_string_literal: true

class ItemParserInteractor
  def self.find_and_create_receipt_items(parser_params, receipt)
    items = find_receipt_items(parser_params)
    ItemParserRangeInteractor.create_receipt_items(items, receipt)
  end

  def self.find_receipt_items(params)
    file_parse = ItemParserRangeInteractor.find_file_parse(params)
    return unless file_parse.length != 1
    total_items = receipt_items_zero_length(params, file_parse)
    total_items
  end

  def self.receipt_items_zero_length(params, file_parse)
    pattern = /(ABN)|(SUBTOTAL)/
    parsed_txt = file_parse[1].gsub(/\\r\\n/, "\n").split("\n")
    items_range = parsed_txt.each_index.select { |index| parsed_txt[index][pattern] }[0, 2]
    amount = ItemParserRangeInteractor.total_paid_amount(params)
    if items_range.length.zero?
      total_items = ItemParserRangeInteractor.find_items(parsed_txt)
    elsif items_range.length == 1
      total_items = find_items_for_item_range(parsed_txt, amount)
    else
      total_items = ItemParserRangeInteractor.find_items_for_item_range_2(parsed_txt,
                                                                          items_range,
                                                                          amount)
    end
    total_items
  end

  def self.find_price_using_price_range(price_range, parsed_txt, amount)
    price = []
    if price_range.length == 1
      price_range_end = parsed_txt.each_index.select do |index|
        parsed_txt[index] == (amount + ' ')
      end
                                  .first
      price_range_start = price_range[0]
      ((price_range_start + 1)...price_range_end).each { |i| price << parsed_txt[i] }
    else
      price = find_price_range_zero(price, price_range, parsed_txt, amount)
    end
    price
  end

  def self.find_price_range_zero(price, price_range, parsed_txt, amount)
    price_range_start, price_range_end = find_price_range(price_range, parsed_txt)
    ((price_range_start + 1)...price_range_end - 1).each { |i| price << parsed_txt[i] }
    price_range_start = parsed_txt.each_index.select do |index|
      parsed_txt[index][/(TOTAL)/]
    end
                                  .first
    price_range_end = parsed_txt.each_index.select do |index|
      parsed_txt[index] == (amount + ' ')
    end
                                .second
    ((price_range_start + 1)...price_range_end - 1).each { |i| price << parsed_txt[i] }
    price
  end

  def self.find_price_range(price_range, parsed_txt)
    price_range_start = price_range[0]
    price_range_pattern = %r{(\d{2}\/\d{2}\/\d{4})}
    price_range_end = parsed_txt.each_index.select do |index|
      parsed_txt[index][price_range_pattern]
    end
                                .first
    [price_range_start, price_range_end]
  end

  def self.find_items_for_item_range(parsed_txt, amount)
    items = []
    total_items = []
    pattern = /(Time)|(Total for)/
    items_range = parsed_txt.each_index.select { |index| parsed_txt[index][pattern] }[0, 2]
    total_items = if items_range.length == 1
                    ItemParserRangeInteractor.find_items(parsed_txt)
                  else
                    item_range_zero_length(items_range,
                                           items,
                                           parsed_txt,
                                           amount,
                                           total_items)
                  end
    total_items
  end

  def self.item_range_zero_length(items_range, items, parsed_txt, amount, total_items)
    ((items_range[0] + 1)...items_range[1]).each { |i| items << parsed_txt[i] }
    price_range = parsed_txt.each_index.select { |index| parsed_txt[index][/(\d{2}:\d{2})/] }
    price = find_price_using_price_range(price_range, parsed_txt, amount)
    items.each do |item|
      if item.match?(/(\$\d{1,2}\.)|(\$\d{1,2} \. \d{1,2})/)
        total_items[total_items.length - 1]['quantity'] = item[0]
      else
        total_items << ItemParserRangeInteractor.add_single_item(item,
                                                                 1,
                                                                 price[total_items.length])
      end
    end
    total_items
  end
end
