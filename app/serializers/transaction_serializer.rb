# frozen_string_literal: true

class TransactionSerializer
  include JSONAPI::Serializer

  TYPE = 'transaction'
  attribute :topup_id
  attribute :topup_amount
  attribute :method
  attribute :result
  attribute :withdraw_id
  attribute :account_to
  attribute :withdraw_amount
  attribute :transfer
  attribute :transfer_amount
  attribute :account_to
  attribute :account_to
  attribute :created_at
  attribute :updated_at

  attribute :created_at do
    object&.created_at&.to_time&.strftime('%d/%m/%Y %H:%M:%S')
  end

  attribute :updated_at do
    object&.updated_at&.to_time&.strftime('%d/%m/%Y %H:%M:%S')
  end
end
