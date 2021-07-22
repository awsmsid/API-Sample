# frozen_string_literal: true

class AccountSerializer
  include JSONAPI::Serializer

  TYPE = 'account'

  attribute :id
  attribute :bank_name
  attribute :bsb
  attribute :account_number
  attribute :account_name
  attribute :created_at
  attribute :updated_at

  attribute :created_at do
    object&.created_at&.strftime('%d/%m/%Y %H:%M:%S')
  end

  attribute :updated_at do
    object&.updated_at&.strftime('%d/%m/%Y %H:%M:%S')
  end
end
