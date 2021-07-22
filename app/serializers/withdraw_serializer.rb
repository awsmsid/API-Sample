# frozen_string_literal: true

class WithdrawSerializer
  include JSONAPI::Serializer

  TYPE = 'withdraw'

  attribute :id
  attribute :account_to
  attribute :amount
  attribute :created_at
  attribute :updated_at

  attribute :created_at do
    object&.created_at&.strftime('%d/%m/%Y %H:%M:%S')
  end

  attribute :updated_at do
    object&.updated_at&.strftime('%d/%m/%Y %H:%M:%S')
  end
end
