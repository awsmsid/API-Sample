# frozen_string_literal: true

require 'rails_helper'

describe RestClientService do
  describe '.verify_api' do
    let(:api_url) { 'http://xyz.com' }
    let(:application_id) { 'xyz' }
    let(:response) { instance_double('response', body: 'test') }

    before do
      ENV['USER_IDENTITY_API_URL'] = api_url
      ENV['APPLICATION_ID'] = application_id
      allow(RestClient::Request).to receive(:execute).with(any_args)
    end

    subject { described_class.verify_api('abc') }

    it 'send execute to specific URL' do
      expect(RestClient::Request).to receive(:execute).with(any_args) { response }
      subject
    end
  end
end
