# frozen_string_literal: true

require 'rails_helper'

describe BillPaymentInteractor do
  let(:bill_payment) { instance_double('bill_payment', user_id: nil) }
  let(:user_id) { 1 }
  let(:save_result) { true }
  let(:params) do
    {
      account_no: '1234-5678-9012-3456',
      utility_type_id: '1',
      company_id: '1',
      bill_amount: 100.00
    }
  end

  before do
    allow(bill_payment).to receive(:save).and_return(save_result)
    allow(bill_payment).to receive(:errors).and_return([])
    allow(UtilityType).to receive(:find_by_id).and_return(true)
    allow(BillCompany).to receive(:find_by_id).and_return(true)
    allow(bill_payment).to receive(:user_id=).with(user_id).and_return(true)
    allow(JSONAPI::Serializer).to receive(:serialize).with(bill_payment)
    allow(BillPayment).to receive(:new).and_return(bill_payment)
  end

  describe '.create_bill_payment' do
    subject { described_class.create_bill_payment(params, user_id) }

    let(:response) do
      { body: nil, code: 200 }
    end

    context 'when bill_payment is created' do
      it { is_expected.to eq response }
    end

    context 'when validation failed' do
      before do
        allow(UtilityType).to receive(:find_by_id).and_return(false)
      end

      let(:response) do
        { 'body': { 'error' => 'utility_type does not exist' }, 'code': 422 }
      end

      it { is_expected.to eq response }
    end
  end

  describe '.save_payment' do
    subject { described_class.save_payment(params, user_id) }

    let(:response) do
      { 'body': { 'error' => [] }, 'code': 422 }
    end

    before do
      allow(bill_payment).to receive(:save).and_return(false)
    end

    context 'when save_payment is failed' do
      it { is_expected.to eq response }
    end
  end
end
