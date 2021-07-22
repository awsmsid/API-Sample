# frozen_string_literal: true

require 'rails_helper'

describe Game do
  let(:amount) { 10 }
  let(:user_id) { '1' }
  let(:game_id) { 123_456 }
  let(:game) do
    described_class.new(amount: amount,
                        user_id: user_id,
                        game_id: game_id)
  end

  describe 'validate' do
    subject { game.valid? }

    context 'with empty user_id' do
      let(:user_id) { nil }

      it { is_expected.to eq false }
    end

    context 'with empty game_id' do
      let(:game_id) { nil }

      it { is_expected.to eq false }
    end
  end
end
