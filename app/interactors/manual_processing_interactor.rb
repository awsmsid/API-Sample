# frozen_string_literal: true

class ManualProcessingInteractor
  def self.index(params, user_id)
    if params[:mine] == 'true'
      ManualProcessing.where(process_by: user_id, processed: false)
    else
      ManualProcessing.where(process_by: nil)
    end
  end
end
