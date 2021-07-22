# frozen_string_literal: true

require 'rails_helper'

describe TransactionsController do
  let(:transaction) { instance_double('transaction') }
  let(:user_id) { 1 }

  before do
    allow(controller).to receive(:verify_api).and_return(true)
    allow(transaction).to receive(:[]=).with(:user_id, user_id)
    allow(JSONAPI::Serializer).to receive(:serialize).with(transaction)
  end

  describe 'GET index' do
    let(:transactions) do
      [Transaction.new(topup_id: 1, topup_amount: '10')]
    end

    before do
      allow(Transaction).to receive(:where).and_return(transactions)
      allow(JSONAPI::Serializer).to receive(:serialize).with(transactions,
                                                             is_collection: true)
    end

    subject { get :index }

    context 'when success' do
      it { is_expected.to have_http_status(:ok) }
    end
  end
end
