# frozen_string_literal: true

require 'rails_helper'

describe MailjetService do
  user = FactoryBot.create(:user)
  forgot_password = FactoryBot.create(:forgot_password)

  describe '#mailjet_service' do
    it 'do not raise_error' do
      expect { described_class.send_forgot_password_email(user, forgot_password) }
        .not_to raise_error
    end
  end
end
