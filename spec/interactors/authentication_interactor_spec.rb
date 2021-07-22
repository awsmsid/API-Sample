# frozen_string_literal: true

require 'rails_helper'

describe AuthenticationInteractor do
  describe 'user_from_token' do
    subject { described_class.new('token').user_from_token }

    before do
      allow(User).to receive(:find_by_token).and_return(true)
    end

    it { is_expected.to be true }
  end
end
