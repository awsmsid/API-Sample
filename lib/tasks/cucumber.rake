# frozen_string_literal: true

desc 'Verify the code with rails_best_practices'
task :cucumber do
  sh('cucumber')
end
