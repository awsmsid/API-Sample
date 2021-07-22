# frozen_string_literal: true

require 'rails_helper'

describe Withdraw do
  let(:amount) { '10' }
  let(:account_to) { 1 }
  let(:withdraw) do
    described_class.new(amount: account_to, account_to: account_to)
  end

  describe 'validate' do
    subject { withdraw.valid? }

    context 'with empty amount' do
      let(:amount) { nil }

      it { is_expected.to eq false }
    end

    context 'with empty account_to' do
      let(:account_to) { nil }

      it { is_expected.to eq false }
    end
  end
end
