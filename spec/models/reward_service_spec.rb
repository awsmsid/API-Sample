# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RewardService, type: :model do
  let(:user_id) { 1 }
  let(:game_token) { 1234 }
  let(:credit_money) { 10 }
  let(:reward_service) do
    described_class.new(user_id: user_id,
                        game_token: game_token,
                        credit_money: credit_money)
  end

  describe 'validate' do
    subject { reward_service.valid? }

    context 'with empty user id' do
      let(:user_id) { nil }

      it { is_expected.to eq false }
    end
  end
end
