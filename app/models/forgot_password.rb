# frozen_string_literal: true

class ForgotPassword < ApplicationRecord
  before_create :create_token
  belongs_to :user

  def self.create_record(user)
    forgot_password = create!(expiry: Time.zone.now + ENV['VALIDITY_PERIOD'].to_i.hours,
                              user_id: user.id)
    MailjetService.send_forgot_password_email(user, forgot_password)
    forgot_password
  end

  private

  def create_token
    self.token = SecureRandom.urlsafe_base64(nil, false)
  end
end
