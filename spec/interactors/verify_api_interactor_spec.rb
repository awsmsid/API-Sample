# frozen_string_literal: true

require 'rails_helper'

describe VerifyApiInteractor do
  let(:application_id) { 'xyz' }
  let(:cia_url) { 'http://xyz.com' }
  let(:login_token) { 'xyz' }
  let(:params) do
    {
      data: {
        type: 'RewardService',
        attributes: {
          'user-id': '1'
        }
      }
    }
  end
  let(:response) do
    { body: nil, code: 200 }
  end

  before do
    allow(RestClientService).to receive(:verify_api).and_return(response)
    ENV['USER_IDENTITY_API_URL'] = cia_url
  end

  describe '.create_registration' do
    subject { described_class.verify(params, login_token) }

    context 'when user is created' do
      it { is_expected.to eq response }
    end
  end
end
