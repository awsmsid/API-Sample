# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BillCompanySerializer do
  let(:id) { '1000' }
  let(:name) { 'test' }
  let(:bill_company) do
    BillCompany.new(
      id: id,
      name: name
    )
  end

  subject { JSONAPI::Serializer.serialize(bill_company) }

  it { is_expected.to have_jsonapi_attributes('name' => name) }
end
