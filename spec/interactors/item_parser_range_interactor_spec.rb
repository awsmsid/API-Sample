# frozen_string_literal: true

require 'rails_helper'

describe ItemParserRangeInteractor do
  let(:customer) { instance_double('customer') }
  let(:existing_customer) { instance_double('customer') }
  let(:parsed_txt) { 'abc' }
  let(:items_range) { nil }
  let(:amount) { 0 }
  let(:items) { nil }
  let(:price) { 0 }
  let(:total_items) { nil }
  let(:receipt) { nil }
  let(:receipt_items) { 'abc' }
  let(:item) { nil }
  let(:paid_params) { nil }

  describe '.find_items_for_item_range_2' do
    subject { described_class.find_items_for_item_range_2(parsed_txt, items_range, amount) }

    context 'when items not found' do
      it { is_expected.to eq nil }
    end
  end

  describe '.total_items_item_range2' do
    subject { described_class.total_items_item_range2(items, price, total_items) }

    context 'when items not found' do
      it { is_expected.to eq nil }
    end
  end

  describe '.find_items' do
    subject { described_class.find_items(parsed_txt) }

    context 'when items not found' do
      it { is_expected.to eq nil }
    end
  end

  describe '.create_receipt_items' do
    subject { described_class.create_receipt_items(receipt_items, receipt) }

    context 'when items not found' do
      it { is_expected.to eq nil }
    end
  end

  describe '.find_price' do
    subject { described_class.find_price(item) }

    context 'when items not found' do
      it { is_expected.to eq nil }
    end
  end

  describe '.total_paid_amount' do
    subject { described_class.total_paid_amount(paid_params) }

    context 'when items not found' do
      it { is_expected.to eq nil }
    end
  end
end
