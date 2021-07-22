# frozen_string_literal: true

require 'rails_helper'

describe ForgotPasswordController do
  before { FactoryBot.create(:user) }

  describe 'POST create' do
    subject { post :create, params: params }

    context 'when email is found' do
      let(:params) do
        { data: { attributes: { email: 'saddam1@mivi.com.au' } } }
      end

      before do
        allow(JSONAPI::Serializer).to receive(:serialize).and_return(true)
      end

      it { is_expected.to have_http_status(200) }
    end

    context 'when email is not found' do
      let(:params) do
        { data: { attributes: { email: 'saddam@mivi.com' } } }
      end

      it { is_expected.to have_http_status(404) }
    end

    context 'when wrong params passed' do
      let(:params) do
        { data: '' }
      end

      it { is_expected.to have_http_status(500) }
    end
  end
end
