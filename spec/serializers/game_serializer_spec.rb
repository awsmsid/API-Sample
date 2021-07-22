# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GameSerializer do
  let(:id) { '1000' }
  let(:amount) { 10 }
  let(:user_id) { 1 }
  let(:game_id) { 123_456 }
  let(:top_up) do
    Game.new(
      id: id,
      amount: amount,
      user_id: user_id,
      game_id: game_id
    )
  end

  subject { JSONAPI::Serializer.serialize(top_up) }

  it { is_expected.to have_jsonapi_attributes('amount' => amount) }
end
