# frozen_string_literal: true

require 'rails_helper'

describe User do
  let(:fullname) { 'michael febrianto' }
  let(:email) { 'michaelfebrianto@gmail.com' }
  let(:mobile_number) { '0434889994' }
  let(:password) { 'password' }
  let(:password_confirmation) { 'password' }
  let(:gender) { 'gender' }
  let(:dob) { '22/02/1986' }
  let(:address) { 'this is the address' }
  let(:user) do
    described_class.new(fullname: fullname,
                        email: email,
                        mobile_number: mobile_number,
                        password: password,
                        password_confirmation: password_confirmation,
                        gender: gender,
                        dob: dob,
                        address: address)
  end

  describe 'validate' do
    subject { user.valid? }

    context 'with empty email' do
      let(:email) { nil }

      it { is_expected.to eq false }
    end
  end

  describe 'save' do
    subject do
      user.save
      user.token
    end

    context 'with token' do
      it { is_expected.not_to eq nil }
    end
  end
end
