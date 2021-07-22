# frozen_string_literal: true

require 'rails_helper'

describe WithdrawController do
  let(:withdraw) { instance_double('withdraw') }
  let(:user_id) { 1 }
  let(:params) do
    {
      data: {
        type: 'withdraw',
        attributes: {
          account_to: 1,
          amount: 1
        }
      }
    }
  end

  before do
    allow(controller).to receive(:verify_api).and_return(true)
    allow(WithdrawInteractor).to receive(:create_withdraw).with(any_args) do
      { body: withdraw, code: 200 }
    end
    allow(JSONAPI::Serializer).to receive(:serialize).with(withdraw)
  end

  describe 'POST create' do
    subject { post :create, params: params }

    context 'when success' do
      it { is_expected.to have_http_status(:ok) }
    end
  end

  describe 'GET index' do
    subject { get :index }

    let(:withdraws) do
      [Withdraw.new(id: 1, account_to: 1)]
    end

    before do
      allow(JSONAPI::Serializer).to receive(:serialize).with(withdraws,
                                                             is_collection: true)
      allow(WithdrawInteractor).to receive(:index).and_return(withdraws)
    end

    context 'when success' do
      it { is_expected.to have_http_status(:ok) }
    end
  end
end
