# frozen_string_literal: true

class ReceiptPartial < ApplicationRecord
  has_attached_file :picture,
                    styles: { medium: '300x300>', thumb: '100x100>' },
                    default_url: '/images/:style/missing.png'
  validates_attachment :picture, presence: true
  do_not_validate_attachment_file_type :picture

  belongs_to :receipt
  validates :receipt_id, presence: true
  has_many :receipt_items, dependent: :destroy
end
