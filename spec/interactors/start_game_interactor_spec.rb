# frozen_string_literal: true

require 'rails_helper'

describe StartGameInteractor do
  let(:game) { instance_double('game') }
  let(:reward_service) { instance_double('reward_service') }
  let(:user_id) { 1 }
  let(:game_id) { 12_345 }
  let(:amount) { 1 }
  let(:save_result) { true }

  before do
    allow(reward_service).to receive(:update).and_return(true)
    allow(Game).to receive(:new).and_return(game)
    allow(game).to receive(:save).and_return(save_result)
    allow(RewardService).to receive(:where).and_return([reward_service])
    allow(JSONAPI::Serializer).to receive(:serialize).with(game)
    allow(reward_service).to receive(:game_token).and_return(1)
    allow(game).to receive(:errors).and_return([])
    allow(reward_service).to receive(:errors).and_return([])
  end

  describe '.create_game' do
    subject { described_class.create_game(user_id) }

    let(:response) do
      { body: nil, code: 200 }
    end

    context 'when reward service is present' do
      before do
        allow(reward_service).to receive(:blank?).and_return(false)
      end

      it { is_expected.to eq response }
    end

    context 'when validation failed' do
      before do
        allow(game).to receive(:save).and_return(false)
      end

      let(:response) do
        { 'body': { 'error' => [] }, 'code': 422 }
      end

      it { is_expected.to eq response }
    end

    context 'when reward service is blank' do
      before do
        allow(RewardService).to receive(:where).and_return([])
      end

      let(:response) do
        { 'body': { 'error' => 'reward service does not exist' }, 'code': 422 }
      end

      it { is_expected.to eq response }
    end
  end

  describe '.update_reward_service' do
    subject { described_class.update_reward_service(reward_service, game) }

    let(:response) do
      { body: nil, code: 200 }
    end

    it { is_expected.to eq response }

    context 'when reward service validation failed' do
      before do
        allow(reward_service).to receive(:update).and_return(false)
      end

      let(:response) do
        { 'body': { 'error' => [] }, 'code': 422 }
      end

      it { is_expected.to eq response }
    end
  end
end
