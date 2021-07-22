# frozen_string_literal: true

require 'rails_helper'

describe Account do
  let(:bank_name) { 'sbi' }
  let(:bsb) { '123456' }
  let(:account_number) { '1234-5678-9012-3456' }
  let(:account_name) { 'saddam' }
  let(:account) do
    described_class.new(bank_name: bank_name,
                        bsb: bsb,
                        account_number: account_number,
                        account_name: account_name)
  end

  describe 'validate' do
    subject { account.valid? }

    context 'with empty bank_name' do
      let(:bank_name) { nil }

      it { is_expected.to eq false }
    end

    context 'with empty bsb' do
      let(:bsb) { nil }

      it { is_expected.to eq false }
    end

    context 'with empty account_number' do
      let(:account_number) { nil }

      it { is_expected.to eq false }
    end

    context 'with empty account_name' do
      let(:account_name) { nil }

      it { is_expected.to eq false }
    end
  end
end
