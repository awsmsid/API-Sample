# frozen_string_literal: true

require 'rails_helper'

describe ReceiptInteractor do
  let(:receipt) { instance_double('receipt', user_id: nil) }
  let(:status) { 1 }
  let(:manual_entry_by) { 1 }
  let(:manual_pocessing) { instance_double('manual_pocessing') }
  let(:params) do
    {
      status: 'rejected'
    }
  end

  before do
    allow(receipt).to receive(:save).and_return(true)
    allow(receipt).to receive(:status=).with(any_args) { status }
    allow(receipt).to receive(:manual_entry_by=).with(any_args) { manual_entry_by }
    allow(receipt).to receive(:errors).and_return([])
    allow(JSONAPI::Serializer).to receive(:serialize).with(receipt)
    allow(manual_pocessing).to receive(:update).and_return(true)
    allow(receipt).to receive(:manual_processing).and_return(manual_pocessing)
    allow(manual_pocessing).to receive(:errors).and_return([])
  end

  describe '.update_receipt_status' do
    subject { described_class.update_receipt_status(receipt, params) }

    context 'when status is rejected' do
      it { is_expected.to eq true }
    end
  end

  describe '.receipts_reject' do
    subject { described_class.receipts_reject(receipt) }

    context 'when manual_processing doesnot exist' do
      let(:response) do
        { 'body': { 'error' => 'manual_processing doesnot exist' }, 'code': 422 }
      end

      before do
        allow(receipt).to receive(:manual_processing).and_return(nil)
      end

      it { is_expected.to eq response }
    end

    context 'when receipt not updated' do
      let(:response) do
        { 'body': { 'error' => [] }, 'code': 422 }
      end

      before do
        allow(receipt).to receive(:save).and_return(false)
      end

      it { is_expected.to eq response }
    end

    context 'when manual processing is updated' do
      let(:response) do
        { body: nil, code: 200 }
      end

      it { is_expected.to eq response }
    end

    context 'when manual processing is failed' do
      let(:response) do
        { 'body': { 'error' => [] }, 'code': 422 }
      end

      before do
        allow(manual_pocessing).to receive(:update).and_return(false)
      end

      it { is_expected.to eq response }
    end
  end
end
