# frozen_string_literal: true

class BillPaymentSerializer
  include JSONAPI::Serializer

  TYPE = 'bill_payment'

  attribute :id
  attribute :user_id
  attribute :account_no
  attribute :utility_type
  attribute :company_name
  attribute :bill_amount

  attribute :utility_type do
    object.utility_type&.name
  end

  attribute :company_name do
    object.bill_company&.name
  end
end
