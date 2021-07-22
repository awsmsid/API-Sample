# frozen_string_literal: true

require 'rails_helper'

describe RewardServiceInteractor do
  let(:reward_service) { instance_double('reward_service') }
  let(:user_id) { 1 }
  let(:save_result) { true }
  let(:params) do
    {
      user_id: 1
    }
  end

  before do
    allow(reward_service).to receive(:save).and_return(save_result)
    allow(RewardService).to receive(:find_by_user_id).and_return(nil)
    allow(JSONAPI::Serializer).to receive(:serialize).with(reward_service)
    allow(RewardService).to receive(:new).and_return(reward_service)
  end

  describe '.create_reward_service' do
    subject { described_class.create(params) }

    let(:response) do
      { body: nil, code: 200 }
    end

    context 'when reward_service is created' do
      it { is_expected.to eq response }
    end

    context 'when validation failed' do
      before do
        allow(RewardService).to receive(:find_by_user_id).and_return(true)
      end

      let(:response) do
        { 'body': { 'error' => 'record already exist use PATCH instead' }, 'code': 400 }
      end

      it { is_expected.to eq response }
    end
  end
end
