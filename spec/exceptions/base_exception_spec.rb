# frozen_string_literal: true

require 'rails_helper'

describe BaseException do
  describe '#to_hash' do
    let(:base_exception) { described_class.new }

    subject { base_exception.to_hash['status'] }

    context 'when success' do
      it { is_expected.to be_nil }
    end
  end
end
