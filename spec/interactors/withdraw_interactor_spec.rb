# frozen_string_literal: true

require 'rails_helper'

describe WithdrawInteractor do
  let(:withdraw) { instance_double('withdraw') }
  let(:account) { FactoryBot.create(:account) }
  let(:reward_service) { instance_double('reward_service', user_id: nil) }
  let(:user) { instance_double('user') }
  let(:user_id) { 1 }
  let(:save_result) { true }
  let(:params) do
    {
      amount: 1,
      account_to: account.id
    }
  end
  let(:accounts) do
    [Account.new(id: 1, user_id: 1)]
  end
  let(:withdraws) do
    [Withdraw.new(id: 1, account_to: 1)]
  end

  before do
    allow(Withdraw).to receive(:new).and_return(withdraw)
    allow(withdraw).to receive(:save).and_return(withdraw)
    allow(withdraw).to receive(:errors).and_return([])
    allow(JSONAPI::Serializer).to receive(:serialize).with(withdraw)
    allow(User).to receive(:find).and_return(user)
    allow(user).to receive(:reward_service).and_return(reward_service)
  end

  describe '.create_withdraw' do
    subject { described_class.create_withdraw(params, user_id) }

    context 'when user_account_exist is not present' do
      let(:response) do
        { 'body': { 'error' => 'Account does not exist' }, 'code': 422 }
      end

      before do
        allow(Account).to receive(:where).and_return(nil)
      end

      it { is_expected.to eq response }
    end

    context 'when amount is insufficient' do
      let(:response) do
        { 'body': { 'error' => 'insufficient amount' }, 'code': 422 }
      end

      before do
        allow(Account).to receive(:where).and_return(true)
        allow(user).to receive(:reward_service_credit_money).and_return(0)
      end

      it { is_expected.to eq response }
    end

    context 'when withdraw is saved' do
      let(:response) do
        { body: nil, code: 200 }
      end

      before do
        allow(Account).to receive(:where).and_return(true)
        allow(user).to receive(:reward_service_credit_money).and_return(1)
        allow(withdraw).to receive(:save).and_return(true)
      end

      it { is_expected.to eq response }
    end

    context 'when validation failed' do
      let(:response) do
        { 'body': { 'error' => [] }, 'code': 422 }
      end

      before do
        allow(Account).to receive(:where).and_return(true)
        allow(user).to receive(:reward_service_credit_money).and_return(1)
        allow(withdraw).to receive(:save).and_return(false)
      end

      it { is_expected.to eq response }
    end
  end

  describe '.index' do
    subject { described_class.index(user_id) }

    context 'when account is not present' do
      before do
        allow(Account).to receive(:where).and_return(nil)
      end

      it { is_expected.to eq [] }
    end

    context 'when withdraws is present' do
      before do
        allow(Account).to receive(:where).and_return(accounts)
        allow(Withdraw).to receive(:where).and_return(withdraws)
      end

      it { is_expected.to eq withdraws }
    end
  end
end
