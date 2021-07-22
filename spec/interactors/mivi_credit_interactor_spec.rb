# frozen_string_literal: true

require 'rails_helper'

describe MiviCreditInteractor do
  let(:amount) { '$92.04' }

  ENV['MIVI_CREDIT'] = '30'

  describe '.credit' do
    subject { described_class.credit(amount) }

    context 'when credit score is calculated' do
      it { is_expected.to eq 3 }
    end
  end
end
