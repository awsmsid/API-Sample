# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WithdrawSerializer do
  let(:id) { '1000' }
  let(:amount) { '1' }
  let(:account_to) { 1 }
  let(:withdraw) do
    Withdraw.new(
      id: id,
      amount: amount,
      account_to: account_to
    )
  end

  subject { JSONAPI::Serializer.serialize(withdraw) }

  it { is_expected.to have_jsonapi_attributes('amount' => 0.1e1) }

  it { is_expected.to have_jsonapi_attributes('account-to' => account_to) }
end
