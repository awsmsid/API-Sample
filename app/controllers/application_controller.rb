# frozen_string_literal: true

class ApplicationController < ActionController::API
  attr_accessor :user_id

  rescue_from StandardError, with: :internal_error
  rescue_from BaseException, with: :render_error_response
  rescue_from RestClient::Exception, with: :render_rest_client_response

  def verify_api
    Rails.logger.info "request: #{params}"
    Rails.logger.info "user-session-token: #{request.headers['user-session-token']}"
    VerifyApiInteractor.verify(request.headers['user-id'],
                               request.headers['user-session-token'])
    @user_id = request.headers['user-id']
  end

  def render_errors(entity)
    render json: entity.errors, status: :unprocessable_entity
  end

  def healthcheck
    render status: 200
  end

  def render_error_response(error)
    render json: JSONAPI::Serializer.serialize_errors(error.to_hash), status: 405
  end

  def internal_error(error)
    logger.error error.backtrace
    render json: { error: error.message }.to_json, status: 500
  end

  def render_rest_client_response(error)
    logger.error error.backtrace
    body = error&.response&.body
    message = JSON body if body.present?
    Rails.logger.info message
    render json: message, status: error.http_code
  end
end
