# frozen_string_literal: true

require 'rails_helper'

describe WonController do
  let(:reward_service) { instance_double('reward_service') }
  let(:reward_service_id) { 1 }
  let(:user_id) { 1 }
  let(:save_result) { true }
  let(:params) do
    {
      data: {
        type: 'Won',
        attributes: {
          level: '1'
        }
      }
    }
  end

  before do
    allow(controller).to receive(:verify_api).and_return(true)
    allow(reward_service).to receive(:[]=).with(:user_id, user_id)
    allow(reward_service).to receive(:valid?).and_return(true)
    allow(reward_service).to receive(:update).and_return(save_result)
    allow(reward_service).to receive(:errors).and_return([])
    allow(WonInteractor).to receive(:create_won).with(any_args) do
      { body: reward_service, code: 200 }
    end
    allow(JSONAPI::Serializer).to receive(:serialize).with(reward_service)
  end

  describe 'POST create' do
    subject { post :create, params: params }

    context 'when success' do
      it { is_expected.to have_http_status(:ok) }
    end
  end
end
