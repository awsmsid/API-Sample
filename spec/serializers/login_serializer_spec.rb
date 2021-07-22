# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LoginSerializer do
  let(:id) { '1234' }
  let(:token) { '12313asd123sd' }
  let(:email_address) { 'noreply@mivi.com.au' }
  let(:login) do
    Login.new(
      id: id,
      token: token,
      email: email_address
    )
  end

  subject { JSONAPI::Serializer.serialize(login) }

  it { is_expected.to have_jsonapi_attributes('id' => id) }

  it { is_expected.to have_jsonapi_attributes('token' => token) }

  it { is_expected.to have_jsonapi_attributes('email' => email_address) }
end
