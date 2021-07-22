# frozen_string_literal: true

require 'rails_helper'

describe ReceiptProcessingInteractor do
  let(:reward_service) { instance_double('reward_service') }
  let(:receipt) { instance_double('receipt') }

  describe '.update_reward_services' do
    subject do
      described_class.update_reward_services(receipt)
    end

    before do
      allow(RewardService).to receive(:find_by_user_id).and_return(reward_service)
      allow(receipt).to receive(:user_id).and_return(true)
      allow(reward_service).to receive(:blank?).and_return(false)
      allow(reward_service).to receive(:game_token=).and_return(1)
      allow(reward_service).to receive(:game_token).and_return(1)
      allow(receipt).to receive(:mivi_credit).and_return(0)
      allow(reward_service).to receive(:save).and_return(true)
    end

    context 'when receipt partial updated' do
      it { is_expected.to eq(true) }
    end
  end
end
