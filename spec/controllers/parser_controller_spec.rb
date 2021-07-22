# frozen_string_literal: true

require 'rails_helper'

describe ParserController do
  let(:user_id) { 'user_id' }
  let(:receipt_date) { Time.zone.now.to_s }
  let(:store_name) { 'IGA' }
  let(:receipt) { Receipt.new }
  let(:uploaded_receipt) { fixture_file_upload('../fixtures/SUPA_IGA.jpeg', 'image/jpeg') }

  describe 'POST create' do
    subject { post :create, params: { picture: uploaded_receipt } }

    before do
      controller.instance_variable_set(:@user_id, user_id)
      allow(controller).to receive(:verify_api).and_return(true)
      allow(StoreParserInteractor)
        .to receive(:create_and_parse_receipt).with(any_args) { receipt }
      allow(StoreParserInteractor).to receive(:response_message_code).with(any_args) do
        { body: receipt, code: 200 }
      end
    end

    context 'when success' do
      it { is_expected.to have_http_status(200) }
    end

    context 'when error' do
      before do
        allow(StoreParserInteractor)
          .to receive(:create_and_parse_receipt)
          .with(any_args).and_raise(StandardError.new('error'))
      end
      it { is_expected.to have_http_status(500) }
    end
  end
end
