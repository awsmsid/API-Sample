# frozen_string_literal: true

class ReceiptSerializer
  include JSONAPI::Serializer

  TYPE = 'receipt'
  attribute :name
  attribute :receipt_date
  attribute :address
  attribute :total_paid
  attribute :user_id
  attribute :status
  attribute :image_url
  attribute :manual_entry_by
  attribute :mivi_credit
  attribute :created_at
  attribute :updated_at
  attribute :receipt_partials

  attribute :receipt_date do
    object&.receipt_date&.strftime('%d/%m/%Y %H:%M:%S')
  end

  attribute :receipt_items do
    object&.receipt_items&.select('id', 'item_name', 'quantity', 'price')
  end

  attribute :image_url do
    'https:' + object&.picture&.url
  end

  attribute :receipt_partials do
    JSONAPI::Serializer.serialize(object.receipt_partials, is_collection: true)
  end

  attribute :created_at do
    object&.created_at&.strftime('%d/%m/%Y %H:%M:%S')
  end

  attribute :updated_at do
    object&.updated_at&.strftime('%d/%m/%Y %H:%M:%S')
  end
end
