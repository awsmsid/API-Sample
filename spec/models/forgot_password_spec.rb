# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ForgotPassword, type: :model do
  user = FactoryBot.create(:user)

  describe '#create_record' do
    it 'do not raise_error' do
      expect { ForgotPassword.create_record(user) }.not_to raise_error
    end

    it 'increment the count of ForgotPassword' do
      expect { ForgotPassword.create_record(user) }.to change(ForgotPassword, :count)
        .from(1).to(2)
    end

    it 'return instance of ForgotPassword' do
      expect(ForgotPassword.create_record(user)).to be_instance_of(ForgotPassword)
    end
  end
end
