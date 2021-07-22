# frozen_string_literal: true

require 'rails_helper'

describe TransferInteractor do
  let(:reward_service) { instance_double('reward_service', credit_money: 10) }
  let(:transfer_instance) { Transfer.new }
  let(:user) { instance_double('user') }
  let(:user_id) { 1 }
  let(:params) do
    {
      transfer_to: '1',
      amount: 1
    }
  end

  before do
    allow(Transfer).to receive(:new).and_return(transfer_instance)
    allow(transfer_instance).to receive(:save).and_return(true)
    allow(RewardService).to receive(:find_by_user_id).and_return(reward_service)
    allow(reward_service).to receive(:update).and_return(true)
    allow(JSONAPI::Serializer).to receive(:serialize).and_return(true)
  end

  describe '.create_transfer' do
    subject { described_class.create_transfer(params, user_id) }

    let(:response) do
      { body: true, code: 200 }
    end

    context 'when transfer is created' do
      it { is_expected.to eq response }
    end
  end
end
