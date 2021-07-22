# frozen_string_literal: true

require 'rails_helper'

describe UtilityType do
  let(:name) { 'test' }
  let(:utility_type) do
    described_class.new(name: name)
  end

  describe 'validate' do
    subject { utility_type.valid? }

    context 'with empty name' do
      let(:name) { nil }

      it { is_expected.to eq false }
    end
  end
end
