# frozen_string_literal: true

require 'rails_helper'

describe CheckTokenController do
  before do
    User.skip_callback(:create, :before, :create_token)
    User.create!(fullname: 'saddam husain',
                 email: 'saddam@mivi.com.au',
                 password: 'password',
                 password_confirmation: 'password',
                 token: 'rWCyRUgfLODuc8B4DvA_8w123')
    User.set_callback(:create, :before, :create_token)
  end

  describe 'POST create' do
    subject { post :create, params: params }

    context 'when credentials are valid' do
      let(:params) do
        { data: { attributes: { username: 'saddam@mivi.com.au',
                                token: 'rWCyRUgfLODuc8B4DvA_8w123' } } }
      end

      it { is_expected.to have_http_status(200) }
    end

    context 'when credentials are invalid' do
      let(:params) do
        { data: { attributes: { username: 'saddam@gmail.com', token: '' } } }
      end

      it { is_expected.to have_http_status(401) }
    end

    context 'when wrong params passed' do
      let(:params) do
        { data: '' }
      end

      it { is_expected.to have_http_status(500) }
    end
  end
end
