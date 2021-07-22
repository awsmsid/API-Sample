# frozen_string_literal: true

require 'rails_helper'

describe ReceiptParserInteractor do
  describe '.update_receipt_status' do
    let(:id) { '1' }
    let(:receipt) { Receipt.new }

    subject { described_class.delete(id).is_deleted }

    context 'when is_deleted updated' do
      before do
        allow(Receipt).to receive(:find).with(id) { receipt }
      end
      it { is_expected.to eq true }
    end
  end
end
