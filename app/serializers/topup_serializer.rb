# frozen_string_literal: true

class TopupSerializer
  include JSONAPI::Serializer

  TYPE = 'topup'
  attribute :amount
  attribute :method
  attribute :result
  attribute :transaction_id
  attribute :created_at
  attribute :updated_at

  attribute :created_at do
    object&.created_at&.strftime('%d/%m/%Y %H:%M:%S')
  end

  attribute :updated_at do
    object&.updated_at&.strftime('%d/%m/%Y %H:%M:%S')
  end
end
