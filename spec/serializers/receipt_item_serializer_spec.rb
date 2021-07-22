# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReceiptItemSerializer do
  let(:receipt_id) { 1 }
  let(:item_name) { 'ABC' }
  let(:quantity) { 1 }
  let(:price) { '100' }
  let(:receipt_item) do
    ReceiptItem.new(
      receipt_id: receipt_id,
      item_name: item_name,
      quantity: quantity,
      price: price
    )
  end

  subject { JSONAPI::Serializer.serialize(receipt_item) }

  it { is_expected.to have_jsonapi_attributes('item-name' => item_name) }

  it { is_expected.to have_jsonapi_attributes('quantity' => quantity) }

  it { is_expected.to have_jsonapi_attributes('price' => price) }
end
