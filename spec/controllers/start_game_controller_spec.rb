# frozen_string_literal: true

require 'rails_helper'

describe StartGameController do
  let(:game) { instance_double('game') }
  let(:game_id) { 1 }
  let(:user_id) { 1 }
  let(:save_result) { true }
  let(:params) do
    {
      data: {
        type: 'Game',
        attributes: {
          amount: '10',
          game_id: 12_345
        }
      }
    }
  end

  before do
    allow(controller).to receive(:verify_api).and_return(true)
    allow(game).to receive(:[]=).with(:user_id, user_id)
    allow(game).to receive(:valid?).and_return(true)
    allow(game).to receive(:update).and_return(save_result)
    allow(game).to receive(:errors).and_return([])
    allow(Game).to receive(:find_by_game_id).and_return(game)
    allow(StartGameInteractor).to receive(:create_game).with(any_args) do
      { body: game, code: 200 }
    end
    allow(JSONAPI::Serializer).to receive(:serialize).with(game)
  end

  describe 'POST create' do
    subject { post :create, params: params }

    context 'when success' do
      it { is_expected.to have_http_status(:ok) }
    end
  end

  describe 'PATCH update' do
    subject { patch :update, params: params }

    context 'when success' do
      before do
        allow(game).to receive(:update).and_return(true)
      end

      let(:params) do
        {
          data: {
            type: 'game',
            attributes: {
              amount: '10'
            }
          },
          id: game_id
        }
      end

      it { is_expected.to have_http_status(:ok) }
    end

    context 'when failed' do
      before do
        allow(game).to receive(:update).and_return(false)
      end

      let(:params) do
        {
          data: {
            type: 'game',
            attributes: {
              amount: '2'
            }
          },
          id: game_id
        }
      end

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end
  end
end
