# frozen_string_literal: true

class Customer < ApplicationRecord
  validates  :gender, inclusion: %w[male female]
  validates  :dob, datetime: true
  validates  :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates  :phone_number, presence: true
  validates  :address, presence: true
  validates  :user_id, presence: true, uniqueness: true
end
