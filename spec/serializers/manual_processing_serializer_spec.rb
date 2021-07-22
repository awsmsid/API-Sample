# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ManualProcessingSerializer do
  let(:receipt_id) { 1 }
  let(:manual_processing) do
    ManualProcessing.new(receipt_id: receipt_id)
  end

  subject { JSONAPI::Serializer.serialize(manual_processing) }

  it 'when receipt id matches' do
    expect(subject['data']['attributes']['receipt-id']).to eql(receipt_id.to_s)
  end
end
