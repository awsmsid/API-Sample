# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ForgotPasswordSerializer do
  let(:token) { 'aFU4tey4m_FV99zA86zD7A' }
  let(:forgot_password) do
    Login.new(
      token: token
    )
  end

  subject { JSONAPI::Serializer.serialize(forgot_password) }

  it { is_expected.to have_jsonapi_attributes('token' => token) }
end
