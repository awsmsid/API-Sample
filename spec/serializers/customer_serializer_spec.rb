# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CustomerSerializer do
  let(:id) { '1234' }
  let(:user_id) { '12313asd123sd' }
  let(:full_name) { 'full_name' }
  let(:dob) { '2018-01-10' }
  let(:gender) { 'male' }
  let(:email_address) { 'noreply@mivi.com.au' }
  let(:phone_number) { '0452 6409 226' }
  let(:website) { 'www.website.com' }
  let(:address) { 'address' }
  let(:interests) { 'interest' }
  let(:customer) do
    Customer.new(
      id: id,
      user_id: user_id,
      full_name: full_name,
      dob: dob,
      gender: gender,
      email: email_address,
      phone_number: phone_number,
      website: website,
      address: address,
      interests: interests
    )
  end

  subject { JSONAPI::Serializer.serialize(customer) }

  it { is_expected.to have_jsonapi_attributes('user-id' => user_id) }

  it { is_expected.to have_jsonapi_attributes('full-name' => full_name) }

  it { is_expected.to have_jsonapi_attributes('dob' => dob) }

  it { is_expected.to have_jsonapi_attributes('gender' => gender) }

  it { is_expected.to have_jsonapi_attributes('email' => email_address) }

  it { is_expected.to have_jsonapi_attributes('phone-number' => phone_number) }

  it { is_expected.to have_jsonapi_attributes('website' => website) }

  it { is_expected.to have_jsonapi_attributes('address' => address) }

  it { is_expected.to have_jsonapi_attributes('interests' => interests) }
end
