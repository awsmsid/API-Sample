# frozen_string_literal: true

class Receipt < ApplicationRecord
  has_attached_file :picture,
                    styles: { medium: '300x300>', thumb: '100x100>' },
                    default_url: '/images/:style/missing.png'
  validates_attachment :picture, presence: true
  do_not_validate_attachment_file_type :picture
  has_many :receipt_items, dependent: :destroy
  has_many :receipt_partials, dependent: :destroy
  has_one :manual_processing, dependent: :destroy

  accepts_nested_attributes_for :receipt_items, allow_destroy: true

  validates :user_id, presence: true

  enum status: %i[processing complete rejected manual_processing]
end
