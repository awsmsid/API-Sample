# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReceiptPartialSerializer do
  let(:image_url) { 'https:/images/original/missing.png' }
  let(:receipt_id) { 1 }
  let(:receipt_partial) do
    ReceiptPartial.new(
      receipt_id: receipt_id
    )
  end

  subject { JSONAPI::Serializer.serialize(receipt_partial) }

  it { is_expected.to have_jsonapi_attributes('image-url' => image_url) }
end
