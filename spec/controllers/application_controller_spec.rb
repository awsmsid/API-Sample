# frozen_string_literal: true

require 'rails_helper'
describe ApplicationController do
  describe 'GET healthcheck' do
    it 'returns success code' do
      get :healthcheck
      expect(response).to have_http_status(:ok)
    end
  end

  context 'when has callback' do
    controller do
      class DummyError < BaseException; end

      def dummy
        render text: 'Hello world'
      end

      def raise_error
        raise DummyError
      end
    end

    let(:auth_interactor) { instance_double('auth_interactor') }
    let(:user) { instance_double('user') }

    before do
      allow(user).to receive(:id).and_return(1)
      allow(auth_interactor).to receive(:user_from_token).and_return(user)
    end

    describe '#render_error_response' do
      before do
        routes.draw { get 'raise_error' => 'anonymous#raise_error' }
      end

      it 'returns 405' do
        get :raise_error
        expect(response).to have_http_status(405)
      end
    end
  end

  context 'when has callback' do
    controller do
      class DummyStandardError < StandardError; end

      def dummy
        render text: 'Hello world'
      end

      def raise_error
        raise DummyStandardError
      end
    end

    let(:auth_interactor) { instance_double('auth_interactor') }
    let(:user) { instance_double('user') }

    before do
      allow(user).to receive(:id).and_return(1)
      allow(auth_interactor).to receive(:user_from_token).and_return(user)
    end

    describe '#render_error_response' do
      before do
        routes.draw { get 'raise_error' => 'anonymous#raise_error' }
      end

      it 'returns 405' do
        get :raise_error
        expect(response).to have_http_status(500)
      end
    end
  end

  context 'when has callback' do
    controller do
      class DummyRestClientError < RestClient::Exception; end

      def dummy
        render text: 'Hello world'
      end

      def raise_error
        raise DummyRestClientError
      end
    end

    let(:auth_interactor) { instance_double('auth_interactor') }
    let(:user) { instance_double('user') }

    before do
      allow(user).to receive(:id).and_return(1)
      allow(auth_interactor).to receive(:user_from_token).and_return(user)
    end

    describe '#render_rest_client_response' do
      before do
        routes.draw { get 'raise_error' => 'anonymous#raise_error' }
      end

      it 'returns 405' do
        get :raise_error
        expect(response).to have_http_status(200)
      end
    end
  end
end
