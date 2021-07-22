# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReceiptSerializer do
  let(:id) { 1 }
  let(:user_id) { 1 }
  let(:name) { 'IGA' }
  let(:address) { 'address' }
  let(:total_paid) { '100' }
  let(:receipt_date) { '12/04/2018 15:36:00' }
  let(:receipt) do
    Receipt.new(
      user_id: user_id,
      name: name,
      address: address,
      total_paid: total_paid,
      receipt_date: receipt_date
    )
  end

  subject { JSONAPI::Serializer.serialize(receipt) }

  it { is_expected.to have_jsonapi_attributes('user-id' => user_id) }

  it { is_expected.to have_jsonapi_attributes('address' => address) }

  it { is_expected.to have_jsonapi_attributes('total-paid' => total_paid) }

  it { is_expected.to have_jsonapi_attributes('receipt-date' => receipt_date) }
end
