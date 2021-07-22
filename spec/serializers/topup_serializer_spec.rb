# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TopupSerializer do
  let(:id) { '1000' }
  let(:amount) { 10 }
  let(:topup_method) { 'test' }
  let(:result) { 'pass' }
  let(:top_up) do
    Topup.new(
      id: id,
      amount: amount,
      method: topup_method,
      result: result
    )
  end

  subject { JSONAPI::Serializer.serialize(top_up) }

  it { is_expected.to have_jsonapi_attributes('amount' => amount) }

  it { is_expected.to have_jsonapi_attributes('method' => topup_method) }
end
