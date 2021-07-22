# frozen_string_literal: true

require 'rails_helper'

class DateTimeValidatable
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :dob

  validates :dob, datetime: true
end

RSpec.describe DatetimeValidator do
  subject { DateTimeValidatable.new(dob: dob) }

  context 'when the date valid' do
    let(:dob) { '2018-01-01' }

    it { is_expected.to be_valid }
  end

  context 'when the date is invalid' do
    let(:dob) { 'v' }

    it { is_expected.not_to be_valid }
  end
end
