# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransferSerializer do
  let(:amount) { 10 }
  let(:transfer_to) { 'test' }
  let(:transfer) do
    Transfer.new(
      amount: amount,
      transfer_to: transfer_to
    )
  end

  subject { JSONAPI::Serializer.serialize(transfer) }

  it { is_expected.to have_jsonapi_attributes('amount' => amount) }

  it { is_expected.to have_jsonapi_attributes('transfer-to' => transfer_to) }
end
