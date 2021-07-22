# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReceiptItem, type: :model do
  let(:receipt_id) { 1 }
  let(:item_name) { 'AUSSIE NAT SPROG WATER 1.5L' }
  let(:quantity) { 1 }
  let(:price) { 8.30 }
  let(:reciept_item) do
    described_class.new(receipt_id: receipt_id,
                        item_name: item_name,
                        quantity: quantity,
                        price: price)
  end

  describe 'validate' do
    subject { reciept_item.valid? }

    context 'with empty receipt id' do
      let(:receipt_id) { nil }

      it { is_expected.to eq false }
    end

    context 'with empty item name' do
      let(:item_name) { nil }

      it { is_expected.to eq false }
    end

    context 'with empty quantity' do
      let(:quantity) { nil }

      it { is_expected.to eq false }
    end

    context 'with empty price' do
      let(:price) { nil }

      it { is_expected.to eq false }
    end
  end
end
