# frozen_string_literal: true

require 'rails_helper'

describe WonInteractor do
  let(:reward_service) { instance_double('reward_service', user_id: nil) }
  let(:user_id) { 1 }
  let(:save_result) { true }
  let(:params) do
    {
      level: 1
    }
  end

  ENV['WON_LEVEL_PRICE'] = '[10,20,30]'

  before do
    allow(reward_service).to receive(:update).and_return(save_result)
    allow(reward_service).to receive(:errors).and_return([])
    allow(RewardService).to receive(:find_by_user_id).and_return(reward_service)
    allow(JSONAPI::Serializer).to receive(:serialize).with(reward_service)
    allow(reward_service).to receive(:credit_money).and_return(1)
  end

  describe '.create_won' do
    subject { described_class.create_won(params, user_id) }

    let(:response) do
      { body: nil, code: 200 }
    end

    context 'when reward_service is present' do
      it { is_expected.to eq response }
    end

    context 'when validation failed' do
      before do
        allow(RewardService).to receive(:find_by_user_id).and_return(nil)
      end

      it 'run time exception' do
        expect { subject }.to raise_error(RuntimeError, 'reward service not found')
      end
    end
  end

  describe '.update_won' do
    subject { described_class.update_won(params, reward_service) }

    let(:response) do
      { 'body': { 'error' => [] }, 'code': 422 }
    end

    before do
      allow(reward_service).to receive(:update).and_return(false)
    end

    context 'when update is failed' do
      it { is_expected.to eq response }
    end
  end
end
