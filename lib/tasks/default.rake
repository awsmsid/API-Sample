# frozen_string_literal: true

task :default do
  # Rake::Task['pact:verify'].invoke # to be included as soon as we have implemented the server
  Rake::Task['brakeman:check'].invoke
  Rake::Task['code_quality'].invoke
  Rake::Task['rubocop'].invoke
  Rake::Task['rails_best_practices'].invoke
end
