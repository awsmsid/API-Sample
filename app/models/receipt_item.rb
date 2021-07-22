# frozen_string_literal: true

class ReceiptItem < ApplicationRecord
  belongs_to :receipt, optional: true
  validates :receipt_id, :item_name, :quantity, :price, presence: true
  belongs_to :receipt_partial, optional: true
end
