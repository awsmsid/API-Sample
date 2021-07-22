# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RewardServiceSerializer do
  let(:id) { 1 }
  let(:user_id) { 1 }
  let(:game_token) { 123 }
  let(:credit_money) { 10 }
  let(:reward_service) do
    RewardService.new(
      user_id: user_id,
      game_token: game_token,
      credit_money: credit_money
    )
  end

  subject { JSONAPI::Serializer.serialize(reward_service) }

  it { is_expected.to have_jsonapi_attributes('user-id' => user_id) }

  it { is_expected.to have_jsonapi_attributes('game-token' => game_token) }

  it { is_expected.to have_jsonapi_attributes('credit-money' => credit_money) }
end
