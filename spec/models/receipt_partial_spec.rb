# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReceiptPartial, type: :model do
  let(:receipt_id) { 1 }
  let(:reciept_partial) do
    described_class.new(receipt_id: receipt_id)
  end

  describe 'validate' do
    subject { reciept_partial.valid? }

    context 'with user id' do
      let(:receipt_id) { nil }

      it { is_expected.to eq false }
    end
  end
end
