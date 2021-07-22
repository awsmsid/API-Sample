# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UtilityTypeSerializer do
  let(:id) { '1000' }
  let(:name) { 'test' }
  let(:utility_type) do
    UtilityType.new(
      id: id,
      name: name
    )
  end

  subject { JSONAPI::Serializer.serialize(utility_type) }

  it { is_expected.to have_jsonapi_attributes('name' => name) }
end
