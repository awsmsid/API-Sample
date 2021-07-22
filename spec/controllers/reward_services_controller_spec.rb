# frozen_string_literal: true

require 'rails_helper'

describe RewardServicesController do
  let(:reward_service) { instance_double('reward_service') }
  let(:user_id) { 1 }
  let(:save_result) { true }
  let(:reward_services) do
    [RewardService.new(id: 1, user_id: 1, game_token: 123, credit_money: 10)]
  end
  let(:params) do
    {
      data: {
        type: 'RewardService',
        attributes: {
          user_id: 1
        }
      }
    }
  end

  before do
    allow(reward_service).to receive(:save).and_return(save_result)
    allow(reward_service).to receive(:errors).and_return([])
    allow(RewardService).to receive(:new).and_return(reward_service)
    # allow(controller).to receive(:verify_api).and_return(true)
    allow(RewardService).to receive(:find_by_user_id).and_return(nil)
    allow(VerifyApiInteractor).to receive(:verify).with(any_args).and_return(true)
    allow(RewardServiceInteractor).to receive(:create).with(any_args) do
      { body: reward_service, code: 200 }
    end
  end

  describe 'POST create' do
    subject { post :create, params: params }

    context 'when success' do
      it { is_expected.to have_http_status(:ok) }
    end

    context 'when failed' do
      before do
        allow(RewardServiceInteractor).to receive(:create).with(any_args) do
          { body: reward_service, code: 422 }
        end
      end

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end
  end

  describe 'GET index' do
    subject { get :index, params: params }

    context 'when success' do
      it { is_expected.to have_http_status(:ok) }
    end
  end
end
