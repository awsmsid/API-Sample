# frozen_string_literal: true

class BillReminder < ApplicationRecord
  belongs_to :user
  validates :user_id, :title, presence: true
end
