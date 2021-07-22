# frozen_string_literal: true

require 'rails_helper'

describe AccountsController do
  let(:account) { instance_double('account') }
  let(:save_result) { true }
  let(:params) do
    {
      data: {
        type: 'Account',
        attributes: {
          bank_name: 'test',
          bsb: '123456',
          account_number: '123456789',
          account_name: 'saddam'
        }
      }
    }
  end

  before do
    allow(controller).to receive(:verify_api).and_return(true)
    # allow(account).to receive(:[]=).with(:user_id, user_id)
    allow(account).to receive(:valid?).and_return(true)
    allow(account).to receive(:save).and_return(save_result)
    allow(account).to receive(:errors).and_return([])
    allow(Account).to receive(:new).and_return(account)
    allow(JSONAPI::Serializer).to receive(:serialize).with(account)
  end

  describe 'POST create' do
    subject { post :create, params: params }

    context 'when success' do
      it { is_expected.to have_http_status(:ok) }
    end

    context 'when failed' do
      let(:save_result) { false }

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end
  end

  describe 'GET index' do
    let(:accounts) do
      [Account.new(id: 1, bank_name: 'test')]
    end

    before do
      allow(Account).to receive(:all).and_return(accounts)
      allow(JSONAPI::Serializer).to receive(:serialize).with(accounts,
                                                             is_collection: true)
    end

    subject { get :index }

    context 'when success' do
      it { is_expected.to have_http_status(:ok) }
    end
  end
end
