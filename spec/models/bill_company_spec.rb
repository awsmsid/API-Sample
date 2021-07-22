# frozen_string_literal: true

require 'rails_helper'

describe BillCompany do
  let(:name) { 'test' }
  let(:bill_company) do
    described_class.new(name: name)
  end

  describe 'validate' do
    subject { bill_company.valid? }

    context 'with empty name' do
      let(:name) { nil }

      it { is_expected.to eq false }
    end
  end
end
