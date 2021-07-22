# frozen_string_literal: true

require 'rails_helper'

describe OCRSpaceService do
  describe '.upload' do
    let(:ocr_space_url) { 'http://ocr.space' }
    let(:ocr_space_api_key) { 'adas123sda' }
    let(:response) { instance_double('response', body: 'test') }

    before do
      ENV['OCR_SPACE_URL'] = ocr_space_url
      ENV['OCR_SPACE_API_KEY'] = ocr_space_api_key
      allow(RestClient).to receive(:post).with(any_args)
    end

    subject { described_class.upload('http://imageurl.com') }

    it 'send post to specific URL' do
      expect(RestClient).to receive(:post).with(any_args) { response }
      subject
    end
  end
end
