# frozen_string_literal: true

class RestClientService
  def self.verify_api(verify_params)
    Rails.logger.info 'start verify request'
    Rails.logger.info "body: #{verify_params.to_json}"

    headers = { 'Content-Type': 'application/json',
                application_id: ENV['APPLICATION_ID'] }
    Rails.logger.info "headers: #{headers}"

    response = RestClient::Request.execute(method: :post,
                                           url: ENV['USER_IDENTITY_API_URL'] + '/api/verify',
                                           payload: verify_params,
                                           timeout: 1000,
                                           headers: headers)

    Rails.logger.info 'end request'
    Rails.logger.info response.to_s
    response
  end
end
