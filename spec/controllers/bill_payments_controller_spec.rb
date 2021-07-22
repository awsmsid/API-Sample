# frozen_string_literal: true

require 'rails_helper'

describe BillPaymentsController do
  let(:bill_payment) { instance_double('bill_payment', user_id: nil) }
  let(:user_id) { 1 }
  let(:save_result) { true }
  let(:params) do
    {
      data: {
        type: 'BillPayment',
        attributes: {
          account_no: '1234-5678-9012-3456',
          utility_type_id: '1',
          company_id: '1',
          bill_amount: 100.00
        }
      }
    }
  end

  before do
    allow(controller).to receive(:verify_api).and_return(true)
    controller.instance_variable_set(:@user_id, user_id)
    allow(bill_payment).to receive(:[]=).with(:user_id, user_id)
    allow(bill_payment).to receive(:valid?).and_return(true)
    allow(bill_payment).to receive(:save).and_return(save_result)
    allow(bill_payment).to receive(:errors).and_return([])
    allow(BillPayment).to receive(:new).and_return(bill_payment)
    allow(JSONAPI::Serializer).to receive(:serialize).with(bill_payment)
    allow(BillPaymentInteractor).to receive(:create_bill_payment).with(any_args) do
      { body: bill_payment, code: 200 }
    end
  end

  describe 'POST create' do
    subject { post :create, params: params }

    context 'when success' do
      it { is_expected.to have_http_status(:ok) }
    end

    context 'when failed' do
      before do
        allow(BillPaymentInteractor).to receive(:create_bill_payment).with(any_args) do
          { body: bill_payment, code: 422 }
        end
      end

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end
  end

  describe 'GET index' do
    let(:bill_payments) do
      [BillPayment.new(account_no: 1234, utility_type: 'test', company_name: 'test')]
    end

    before do
      allow(BillPayment).to receive(:where).and_return(bill_payments)
      allow(JSONAPI::Serializer).to receive(:serialize).with(bill_payments,
                                                             is_collection: true)
    end

    subject { get :index }

    context 'when success' do
      it { is_expected.to have_http_status(:ok) }
    end
  end
end
