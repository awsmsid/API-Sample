# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccountSerializer do
  let(:bank_name) { 'sbi' }
  let(:bsb) { '123456' }
  let(:account_number) { '1234-5678-9012-3456' }
  let(:account_name) { 'saddam' }
  let(:account) do
    Account.new(
      bank_name: bank_name,
      bsb: bsb,
      account_number: account_number,
      account_name: account_name
    )
  end

  subject { JSONAPI::Serializer.serialize(account) }

  it { is_expected.to have_jsonapi_attributes('bank-name' => bank_name) }
end
