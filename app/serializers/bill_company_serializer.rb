# frozen_string_literal: true

class BillCompanySerializer
  include JSONAPI::Serializer

  TYPE = 'bill_company'

  attribute :id
  attribute :name
  attribute :created_at
  attribute :updated_at

  attribute :created_at do
    object&.created_at&.strftime('%d/%m/%Y %H:%M:%S')
  end

  attribute :updated_at do
    object&.updated_at&.strftime('%d/%m/%Y %H:%M:%S')
  end
end
