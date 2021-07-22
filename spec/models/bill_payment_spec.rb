# frozen_string_literal: true

require 'rails_helper'

describe BillPayment do
  let(:account_no) { '1234-5678-9012-3456' }
  let(:utility_type_id) { '1' }
  let(:bill_company_id) { '1' }
  let(:bill_amount) { 100.00 }
  let(:bill_payments) do
    described_class.new(account_no: account_no,
                        utility_type_id: utility_type_id,
                        bill_company_id: bill_company_id,
                        bill_amount: bill_amount)
  end

  describe 'validate' do
    subject { bill_payments.valid? }

    context 'with empty account_no' do
      let(:account_no) { nil }

      it { is_expected.to eq false }
    end

    context 'with empty utility_type' do
      let(:utility_type_id) { nil }

      it { is_expected.to eq false }
    end

    context 'with empty company_name' do
      let(:bill_company_id) { nil }

      it { is_expected.to eq false }
    end

    context 'with empty bill_amount' do
      let(:bill_amount) { nil }

      it { is_expected.to eq false }
    end

    # context 'with account_no' do
    #   let(:account_no) { '1234-5678-9012-3456' }

    #   it { is_expected.to eq true }
    # end
  end
end
