# frozen_string_literal: true

class TransferSerializer
  include JSONAPI::Serializer

  TYPE = 'transfer'
  attribute :transfer_to
  attribute :amount
  attribute :user_id
  attribute :created_at
  attribute :updated_at

  attribute :created_at do
    object&.created_at&.strftime('%d/%m/%Y %H:%M:%S')
  end

  attribute :updated_at do
    object&.updated_at&.strftime('%d/%m/%Y %H:%M:%S')
  end
end
