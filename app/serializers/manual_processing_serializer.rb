# frozen_string_literal: true

class ManualProcessingSerializer
  include JSONAPI::Serializer

  TYPE = 'manual_processing'
  attribute :receipt_id
  attribute :process_by
  attribute :processed
end
