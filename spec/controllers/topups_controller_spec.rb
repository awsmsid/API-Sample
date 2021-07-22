# frozen_string_literal: true

require 'rails_helper'

describe TopupsController do
  let(:top_up) { instance_double('topup') }
  let(:save_result) { true }
  let(:user_id) { 1 }
  let(:top_up_id) { 1 }
  let(:params) do
    {
      data: {
        type: 'topups',
        attributes: {
          amount: '10',
          method: 'test',
          result: 'pass'
        }
      }
    }
  end

  before do
    allow(controller).to receive(:verify_api).and_return(true)
    allow(top_up).to receive(:[]=).with(:user_id, user_id)
    allow(top_up).to receive(:valid?).and_return(true)
    allow(top_up).to receive(:save).and_return(save_result)
    allow(top_up).to receive(:errors).and_return([])
    allow(Topup).to receive(:new).and_return(top_up)
    allow(Topup).to receive(:find_by_transaction_id).and_return(top_up)
    allow(JSONAPI::Serializer).to receive(:serialize).with(top_up)
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

  describe 'PATCH update' do
    subject { patch :update, params: params }

    context 'when success' do
      before do
        allow(top_up).to receive(:update).and_return(true)
      end

      let(:params) do
        {
          data: {
            type: 'topups',
            attributes: {
              result: 'pass'
            }
          },
          id: top_up_id
        }
      end

      it { is_expected.to have_http_status(:ok) }
    end

    context 'when failed' do
      before do
        allow(top_up).to receive(:update).and_return(false)
      end

      let(:params) do
        {
          data: {
            type: 'topups',
            attributes: {
              result: 'pass'
            }
          },
          id: top_up_id
        }
      end

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end
  end

  describe 'GET index' do
    let(:top_ups) do
      [Topup.new(id: 1, amount: '10')]
    end

    before do
      allow(Topup).to receive(:where).and_return(top_ups)
      allow(JSONAPI::Serializer).to receive(:serialize).with(top_ups,
                                                             is_collection: true)
    end

    subject { get :index }

    context 'when success' do
      it { is_expected.to have_http_status(:ok) }
    end
  end
end
