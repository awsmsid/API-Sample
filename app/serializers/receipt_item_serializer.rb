# frozen_string_literal: true

class ReceiptItemSerializer
  include JSONAPI::Serializer

  TYPE = 'receipt_item'
  attribute :item_name
  attribute :quantity
  attribute :price
end
