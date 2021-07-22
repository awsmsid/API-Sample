# frozen_string_literal: true

require 'rails_helper'

describe Transfer do
  let(:amount) { 10 }
  let(:transfer_to) { 'test' }
  let(:transfer) do
    described_class.new(amount: amount,
                        transfer_to: transfer_to)
  end

  describe 'validate' do
    subject { transfer.valid? }

    context 'with empty account_no' do
      let(:amount) { nil }

      it { is_expected.to eq false }
    end

    context 'with empty utility_type' do
      let(:transfer_to) { nil }

      it { is_expected.to eq false }
    end
  end
end
