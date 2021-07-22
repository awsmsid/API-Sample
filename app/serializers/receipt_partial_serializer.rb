# frozen_string_literal: true

class ReceiptPartialSerializer
  include JSONAPI::Serializer

  TYPE = 'receipt'
  attribute :id
  attribute :name
  attribute :image_url
  attribute :receipt_date
  attribute :address
  attribute :total_paid
  attribute :user_id
  attribute :status
  attribute :manual_entry_by
  attribute :created_at
  attribute :updated_at

  attribute :image_url do
    'https:' + object&.picture&.url
  end

  attribute :receipt_items do
    object&.receipt_items&.select('id', 'item_name', 'quantity', 'price')
  end

  attribute :created_at do
    object&.created_at&.strftime('%d/%m/%Y %H:%M:%S')
  end

  attribute :updated_at do
    object&.updated_at&.strftime('%d/%m/%Y %H:%M:%S')
  end

  attribute :status do
    Receipt.statuses&.key(object.status)
  end
end
