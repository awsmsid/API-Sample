# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :password_confirmation

  before_create :create_token

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true
  validates :password_confirmation, presence: true
  has_many :forgot_passwords, dependent: :destroy
  has_one :reward_service, dependent: :destroy
  has_one :bill_reminder, dependent: :destroy
  has_many :topups, dependent: :destroy
  delegate :credit_money, to: :reward_service, prefix: true

  private

  def create_token
    self.token = SecureRandom.urlsafe_base64(nil, false)
  end
end
