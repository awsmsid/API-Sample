# frozen_string_literal: true

class MailjetService
  def self.send_forgot_password_email(user, forgot_password)
    Rails.logger.info 'start sending forgot password email'
    Rails.logger.info "from_email: #{ENV['MIALJET_DEFAULT_FROM']}"
    Rails.logger.info "from_name: #{ENV['MIALJET_FROM_NAME']}"
    # Rails.logger.info "text_part: #{forgot_password.token}"
    Rails.logger.info "to: #{user.email}"
    Rails.logger.info "MAILJET_API_KEY: #{ENV['MAILJET_API_KEY']}"
    Rails.logger.info "MAILJET_SECRET_KEY: #{ENV['MAILJET_SECRET_KEY']}"

    Mailjet::Send.create(from_email:  ENV['MIALJET_DEFAULT_FROM'],
                         from_name: ENV['MIALJET_FROM_NAME'],
                         to: user.email,
                         subject: 'Forgot Password',
                         text_part: forgot_password.token)
    Rails.logger.info 'forgot password email sent'
  end
end
