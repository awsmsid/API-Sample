# frozen_string_literal: true

class MiviCreditInteractor
  def self.credit(total_paid)
    return unless ENV['MIVI_CREDIT']
    Rails.logger.info 'Mivi Credit Interactor'
    total = total_paid&.delete('$').to_f
    Rails.logger.info "total : #{total}"
    mivi_credit = total / ENV['MIVI_CREDIT'].to_i
    Rails.logger.info "mivi_credit : #{mivi_credit}"
    mivi_credit.to_i
  end
end
