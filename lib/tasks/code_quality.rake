# frozen_string_literal: true

require 'cane/rake_task'

desc 'Run cane to check quality metrics'
Cane::RakeTask.new(:code_quality) do |cane|
  cane.abc_max = 25
  cane.no_style = true
  cane.no_doc = true
end
