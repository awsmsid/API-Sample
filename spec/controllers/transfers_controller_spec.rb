# frozen_string_literal: true

require 'rails_helper'

describe TransfersController do
  let(:transfer) { instance_double('transfer') }
  let(:save_result) { true }
  let(:user_id) { 1 }
  let(:transfer_id) { 1 }
  let(:params) do
    {
      data: {
        type: 'topups',
        attributes: {
          amount: '10',
          transfer_to: 'test'
        }
      }
    }
  end

  before do
    allow(controller).to receive(:verify_api).and_return(true)
    allow(transfer).to receive(:[]=).with(:user_id, user_id)
    allow(transfer).to receive(:valid?).and_return(true)
    allow(transfer).to receive(:save).and_return(save_result)
    allow(transfer).to receive(:errors).and_return([])
    allow(Transfer).to receive(:new).and_return(transfer)
    allow(JSONAPI::Serializer).to receive(:serialize).with(transfer)
    allow(TransferInteractor).to receive(:create_transfer).with(any_args) do
      { body: transfer, code: 200 }
    end
  end

  describe 'POST create' do
    subject { post :create, params: params }

    context 'when success' do
      it { is_expected.to have_http_status(:ok) }
    end
  end
end
