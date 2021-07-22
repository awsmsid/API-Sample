# frozen_string_literal: true

require 'rails_helper'

describe ReceiptsController do
  let(:receipt) { instance_double('receipt', user_id: nil) }
  let(:receipts) do
    [Receipt.new(id: 1, name: 'coles')]
  end

  before do
    allow(controller).to receive(:verify_api).and_return(true)
    allow(Receipt).to receive(:find_by_user_id).and_return(nil)
  end

  describe 'GET index' do
    subject { get :index }

    context 'when success' do
      it { is_expected.to have_http_status(:ok) }
    end
  end

  describe 'GET index' do
    subject { get :index, params: { order_by: 'name', order_type: 'desc' } }

    context 'when success' do
      it { is_expected.to have_http_status(:ok) }
    end
  end

  describe 'GET show/:id' do
    subject { get :show, params: { id: 1 } }

    context 'when success' do
      it { is_expected.to have_http_status(:ok) }
    end
  end

  describe 'DEL destroy/:id' do
    let(:id) { '1' }

    subject { delete :destroy, params: { id: id } }

    before do
      allow(ReceiptParserInteractor).to receive(:delete).with(id) { receipts[0] }
    end

    context 'when success' do
      it { is_expected.to have_http_status(:ok) }
    end
  end

  describe 'PATCH update' do
    before do
      allow(receipt).to receive(:assign_attributes).and_return(true)
      allow(receipt).to receive(:save).and_return(true)
      allow(JSONAPI::Serializer).to receive(:serialize).with(receipt)
      allow(Receipt).to receive(:find).and_return(receipt)
    end

    let(:params) do
      {
        'data': {
          'attributes': {
            'name': 'abc',
            'receipt_date': '12/04/2018 15:36:00',
            'address': 'abc',
            'total_paid': '$10.99',
            'receipt_items_attributes': [
              {
                'item_name': 'abc nn',
                'quantity': '1',
                'price': '$5.99'
              },
              {
                'item_name': 'abc',
                'quantity': '1',
                'price': '$5.99'
              }
            ]
          }
        },
        'id': 1
      }
    end

    subject { patch :update, params: params }

    context 'when success' do
      it { is_expected.to have_http_status(200) }
    end

    context 'when failed' do
      let(:test_errors) { ['there is an error'] }

      before do
        allow(receipt).to receive(:assign_attributes).and_return(false)
        allow(receipt).to receive(:save).and_return(false)
        allow(receipt).to receive(:errors).and_return(test_errors)
      end

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end
  end

  describe 'PATCH receipts_reject' do
    subject { patch :receipts_reject, params: params }

    let(:params) do
      {
        data: {
          type: 'game',
          attributes: {
          }
        },
        id: 1
      }
    end

    before do
      allow(JSONAPI::Serializer).to receive(:serialize).with(receipt)
      allow(Receipt).to receive(:find).and_return(receipt)
      allow(ReceiptInteractor).to receive(:receipts_reject).with(any_args) do
        { body: receipt, code: 200 }
      end
    end

    context 'when success' do
      it { is_expected.to have_http_status(:ok) }
    end
  end
end
