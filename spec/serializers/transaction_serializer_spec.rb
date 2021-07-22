# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionSerializer do
  let(:topup_id) { 1 }
  let(:topup_amount) { 10 }
  let(:topup_method) { 'test' }
  let(:result) { 'pass' }
  let(:withdraw_id) { 1 }
  let(:withdraw_amount) { 10 }
  let(:transfer) { 1 }
  let(:transfer_amount) { 10 }
  let(:account_to) { 1 }
  let(:transaction) do
    Transaction.new(
      topup_id: topup_id,
      topup_amount: topup_amount,
      method: topup_method,
      result: result,
      withdraw_id: withdraw_id,
      withdraw_amount: withdraw_amount,
      transfer: transfer,
      transfer_amount: transfer_amount,
      account_to: account_to
    )
  end

  subject { JSONAPI::Serializer.serialize(transaction) }

  it { is_expected.to have_jsonapi_attributes('method' => topup_method) }

  it { is_expected.to have_jsonapi_attributes('result' => result) }
end
