# frozen_string_literal: true

class VerifyApiInteractor
  def self.verify(user_id, login_token)
    verify_params = {
      'data': {
        'type': 'verify-token',
        'attributes': {
          'user-session-token': login_token,
          'user-id': user_id
        }
      }
    }
    response = RestClientService.verify_api(verify_params)
    Rails.logger.info "response from user-identity: #{response}"
    response
  end
end
