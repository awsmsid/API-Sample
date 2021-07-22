# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BillPaymentSerializer do
  let(:id) { '1000' }
  let(:account_no) { '1234-5678-9012-3456' }
  let(:utility_type_id) { '1' }
  let(:bill_company_id) { '1' }
  let(:bill_amount) { 100.00 }
  let(:bill_payment) do
    BillPayment.new(
      id: id,
      account_no: account_no,
      utility_type_id: utility_type_id,
      bill_company_id: bill_company_id,
      bill_amount: bill_amount
    )
  end

  subject { JSONAPI::Serializer.serialize(bill_payment) }

  it { is_expected.to have_jsonapi_attributes('account-no' => account_no) }

  it { is_expected.to have_jsonapi_attributes('bill-amount' => bill_amount) }
end
